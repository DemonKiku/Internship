# -*- coding: utf-8 -*-
"""
Created on Wed May  8 14:02:16 2019

@author: Demon
"""
#加载所需包
from matplotlib.path import Path
import pandas as pd
import numpy as np
import glob
import os
from math import *

#读取pp文件
def readpp(filepath):
    file=open(filepath,"r")
    points=file.read()
    points=str(points).split("\n") 
    points=points[8:-2]
    result=np.zeros((len(points),4),dtype="<U32")
    i=0
    for point in points:
        point_temp=point.split(" ")
        point_temp.sort()
        point_temp=point_temp[3:]
        j=0
        for cor in point_temp:
            result[i][j]=cor.split("\"")[1]
            j+=1
        i+=1
    landmarks=np.array(result[:,1:],dtype='float')   #坐标点信息
    names=np.array(result[:,0])#各点名称
    x=np.array(result[:,1])
    y=np.array(result[:,2])
    z=np.array(result[:,3])
    return landmarks,names,result,x,y,z
files=glob.glob(os.path.join("E:\\Internship\\3D_tz\\4",'*.pp'))
point=[]
a=np.zeros((19,1))
b=np.zeros((19,1))
c=np.zeros((19,1))
for f in files:
    print(f)
    landmarks,names,result,x,y,z=readpp(f)  
    #print(result)
    a=np.column_stack((a,x))
    b=np.column_stack((b,y))
    c=np.column_stack((c,z))
    #print(point)
    #point=np.vstack((a,point))
np.savetxt('./4/ml2_x.csv',a,delimiter=',',fmt = '%s')
np.savetxt('./4/ml2_y.csv',b,delimiter=',',fmt = '%s')
np.savetxt('./4/ml2_z.csv',c,delimiter=',',fmt = '%s')
   
    


