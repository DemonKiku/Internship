setwd("C:\\Users\\dell\\Desktop\\landmarks")
#读取所有符合要求的文件
myfiles0 <- Sys.glob("*.csv")
#myfiles <- list.files(pattern = "*.csv")
#循环进行t-test
example=read.csv("names.csv",header = T)
p=example[c("names")]
rownames(p)=p[,1]
for (i in 1:19){
  a=read.csv(myfiles0[i],header = T)
  #人工之间
  p$mlx[i]=t.test(a$ml_x1,a$ml_x2,paired=T)$p.value
  p$mly[i]=t.test(a$ml_y1,a$ml_y2,paired=T)$p.value
  p$mlz[i]=t.test(a$ml_z1,a$ml_z2,paired=T)$p.value
  #机器之间
  p$aux[i]=t.test(a$au_x1,a$au_x2,paired=T)$p.value
  p$auy[i]=t.test(a$au_y1,a$au_y2,paired=T)$p.value
  p$auz[i]=t.test(a$au_z1,a$au_z2,paired=T)$p.value
  #第一次人工与机器
  p$ma1x[i]=t.test(a$ml_x1,a$au_x1,paired=T)$p.value
  p$ma1y[i]=t.test(a$ml_y1,a$au_y1,paired=T)$p.value
  p$ma1z[i]=t.test(a$ml_z1,a$au_z1,paired=T)$p.value
  #第二次人工与机器
  p$ma2x[i]=t.test(a$ml_x2,a$au_x2,paired=T)$p.value
  p$ma2y[i]=t.test(a$ml_y2,a$au_y2,paired=T)$p.value
  p$ma2z[i]=t.test(a$ml_z2,a$au_z2,paired=T)$p.value
}
write.table(p,file = "p-values.csv",sep=",")



