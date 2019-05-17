#设置当前工作目录
setwd("C:\\Users\\dell\\Desktop")
#加载各种包
library(readxl)
library(ggplot2)
library(reshape2)
library(plyr)
library(car)
library(ICC)
library(BlandAltmanLeh)
library(geomorph)
library(GGally)
library(data.table)
library(dplyr)
library(broom)
library(ggpubr)
#定义计算根方差及距离的函数
RMSE = function(fitted, observed){sqrt(mean((fitted - observed)^2))}
EuclideanDistance <- function(x1,x2,y1,y2,z1,z2){sqrt(sum((x1-x2)^2+(y1-y2)^2+(z1-z2)^2))}

#读取文件
a=read.csv("test.csv",sep = ",",header = T)
data <- a[,c("ID", "LM.Num", "LM.Name")]

#计算ml-ml,au-au,ml-au之间的标准差
data$m_sdx <- apply(a[4:ncol(a)], 1, function(x) sd(x[c("ml_x1", "ml_x2")])) 
data$m_sdy <- apply(a[4:ncol(a)], 1, function(x) sd(x[c("ml_y1", "ml_y2")]))
data$m_sdz <- apply(a[4:ncol(a)], 1, function(x) sd(x[c("ml_z1", "ml_z2")]))
data$m_avgsd <- apply(data[4:ncol(data)], 1, function(x) mean(x[c("m_sdx", "m_sdy","m_sdz")]))

data$a_sdx <- apply(a[4:ncol(a)], 1, function(x) sd(x[c("au_x1", "au_x2")]))
data$a_sdy <- apply(a[4:ncol(a)], 1, function(x) sd(x[c("au_y1", "au_y2")]))
data$a_sdz <- apply(a[4:ncol(a)], 1, function(x) sd(x[c("au_z1", "au_z2")]))
data$a_avgsd <- apply(data[4:ncol(data)], 1, function(x) mean(x[c("a_sdx", "a_sdy","a_sdz")]))

data$first_sdx <- apply(a[4:ncol(a)], 1, function(x) sd(x[c("ml_x1", "au_x1")])) 
data$first_sdy <- apply(a[4:ncol(a)], 1, function(x) sd(x[c("ml_y1", "au_y1")]))
data$first_sdz <- apply(a[4:ncol(a)], 1, function(x) sd(x[c("ml_z1", "au_z1")]))
data$first_avgsd <- apply(data[4:ncol(data)], 1, function(x) mean(x[c("first_sdx", "first_sdy","first_sdz")]))

data$second_sdx <- apply(a[4:ncol(a)], 1, function(x) sd(x[c("ml_x2", "au_x2")])) 
data$second_sdy <- apply(a[4:ncol(a)], 1, function(x) sd(x[c("ml_y2", "au_y2")]))
data$second_sdz <- apply(a[4:ncol(a)], 1, function(x) sd(x[c("ml_z2", "au_z2")]))
data$second_avgsd <- apply(data[4:ncol(data)], 1, function(x) mean(x[c("second_sdx", "second_sdy","second_sdz")]))
#算距离差
data$dism<- apply(a[4:ncol(a)], 1, function(x) EuclideanDistance(x["ml_x1"],x["ml_x2"],x["ml_y1"],x["ml_y2"],x["ml_z1"],x["ml_z2"]))
data$disa<- apply(a[4:ncol(a)], 1, function(x) EuclideanDistance(x["au_x1"],x["au_x2"],x["au_y1"],x["au_y2"],x["au_z1"],x["au_z2"]))
data$disma1<- apply(a[4:ncol(a)], 1, function(x) EuclideanDistance(x["ml_x1"],x["au_x1"],x["ml_y1"],x["au_y1"],x["ml_z1"],x["au_z1"]))
data$disma2<- apply(a[4:ncol(a)], 1, function(x) EuclideanDistance(x["ml_x2"],x["au_x2"],x["ml_y2"],x["au_y2"],x["ml_z2"],x["au_z2"]))

#画sd图
ggplot(data = melt(data[, c("ID", "LM.Num", "LM.Name", "m_avgsd", "a_avgsd", "first_avgsd","second_avgsd")], id.vars = c("ID", "LM.Num", "LM.Name")), aes(x=LM.Name, y=value, fill=variable))+geom_boxplot()+theme_minimal()+theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust=0.1), legend.position = "right", legend.title = element_blank())+scale_fill_discrete(breaks=c("m_avgsd", "a_avgsd", "first_avgsd","second_avgsd"), labels=c("ML1-ML2", "AU1-AU2", "ML-AU_1","ML-AU_2"))+ylab("Standard Deviation (mm)")+xlab("Landmark")+ggtitle("Standard deviation of landmarks")

#画距离图
ggplot(data = melt(data[, c("ID", "LM.Num", "LM.Name", "dism", "disa", "disma1","disma2")], id.vars = c("ID", "LM.Num", "LM.Name")), aes(x=LM.Name, y=value, fill=variable))+geom_boxplot()+theme_minimal()+theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust=0.1), legend.position = "right", legend.title = element_blank())+scale_fill_discrete(breaks=c("dism", "disa", "disma1","disma2"), labels=c("ML1-ML2", "AU1-AU2", "ML-AU_1","ML-AU_2"))+ylab("Euclidean Distance (mm)")+xlab("Landmark")+ggtitle("Distance of landmarks")

#出表
SdByLandmark <- ddply(data,~LM.Name,summarise, m_sdx = mean(m_sdx), m_sdy = mean(m_sdy), m_sdz = mean(m_sdz),m_avgsd = mean(m_avgsd), a_sdx = mean(a_sdx), a_sdy = mean(a_sdy), a_sdz = mean(a_sdz), a_avgsd=mean(a_avgsd), first_sdx=mean(first_sdx), first_sdy=mean(first_sdy), first_sdz=mean(first_sdz), first_avgsd=mean(first_avgsd),second_sdx=mean(second_sdx),second_sdy=mean(second_sdy),second_sdz=mean(second_sdz),second_avgsd=mean(second_avgsd))
write.table(SdByLandmark, "Tables/SdByLandmark.txt", row.names = F, col.names = T, quote = F, sep = "\t")

DisByLandmark <- ddply(data,~LM.Name,summarise, dism = mean(dism), disa = mean(disa), disma1 = mean(disma1),disma2 = mean(disma2))
write.table(DisByLandmark, "Tables/DisByLandmark.txt", row.names = F, col.names = T, quote = F, sep = "\t")


