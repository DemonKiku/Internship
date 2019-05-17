setwd("C:\\Users\\dell\\Desktop")
a=read.csv("test.csv",sep = ",",header = T)
b=a[,4:15]
library(BlandAltmanLeh)
mx1=b$ml_x1
mx2=b$ml_x2
my1=b$ml_y1
mz1=b$ml_z1
my2=b$ml_y2
mz2=b$ml_z2
ax1=b$au_x1
ay1=b$au_y1
az1=b$au_z1
ax2=b$au_x2
ay2=b$au_y2
az2=b$au_z2
#par(mfcol=c(4,3))
bland.altman.plot(mx1,mx2,xlab="(mx1+mx2)/2",mode=1, ylab="mx1-mx2",conf.int=0.95,silent=F)
bland.altman.plot(mz1,mz2,xlab="(my1+my2)/2",mode=1, ylab="mz1-mz2",conf.int=0.95,silent=F)
bland.altman.plot(my1,my2,xlab="(mz1+mz2)/2",mode=1, ylab="my1-my2",conf.int=0.95,silent=F)
bland.altman.plot(ax1,ax2,xlab="(ax1+ax2)/2",mode=1, ylab="ax1-ax2",conf.int=0.95,silent=F)
bland.altman.plot(ay1,ay2,xlab="(ay1+ay2)/2",mode=1, ylab="ay1-ay2",conf.int=0.95,silent=F)
bland.altman.plot(az1,az2,xlab="(az1+az2)/2",mode=1, ylab="az1-az2",conf.int=0.95,silent=F)
bland.altman.plot(mx1,ax1,xlab="(mx1+ax1)/2",mode=1, ylab="mx1-ax1",conf.int=0.95,silent=F)
bland.altman.plot(my1,ay1,xlab="(my1+ay1)/2",mode=1, ylab="my1-ay1",conf.int=0.95,silent=F)
bland.altman.plot(mz1,az1,xlab="(mz1+az1)/2",mode=1, ylab="mz1-az1",conf.int=0.95,silent=F)
bland.altman.plot(mx2,ax2,xlab="(mx2+ax2)/2",mode=1, ylab="mx2-ax2",conf.int=0.95,silent=F)
bland.altman.plot(my2,ay2,xlab="(my2+ay2)/2",mode=1, ylab="my2-ay2",conf.int=0.95,silent=F)
bland.altman.plot(mz2,az2,xlab="(mz2+az2)/2",mode=1, ylab="mz2-az2",conf.int=0.95,silent=F)
