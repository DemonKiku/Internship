# -*- coding: utf-8 -*-
"""
Created on Wed Apr 17 10:40:57 2019

@author: Demon
"""
#加载所需包
from matplotlib.path import Path
import pandas as pd
import numpy as np
import glob
import os
from math import *

#计算矩阵中两行间距离
def dist(matrix):
    dis = np.sqrt(sum((matrix[1]-matrix[0])**2))
    return dis

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
    names=np.array(result[:,0])  #各点名称
    return landmarks,names

#加载pp文件
files = glob.glob(os.path.join('./3/','*.pp'))
distance=[]
for f in files:
    #print(f)
    landmarks,names = readpp(f)
    for i in range(0,len(landmarks)):
        for j in range(0,i):
            #提取矩阵中两行，合并成新矩阵
            a = landmarks[i]
            b = landmarks[j]
            d = np.vstack((a,b))
            #计算特征点间距离
            distance_temp = dist(d)
            distance_name = names[i] + '_' + names[j]
            #将特征点名称和距离合并成新矩阵
            distance_final = np.hstack((distance_name,distance_temp))
            distance.append(distance_final)
            #print(distance)
            #将计算好的距离及名称保存至一个csv文件
            np.savetxt(f.split("_")[0]+'_distance.csv',distance,delimiter=',',fmt = '%s')
    distance=[]
#读取csv文件
phenotype = glob.glob(os.path.join('./3/','*.csv'))  
#读取其中一个csv，获取各个距离的名称
a=np.genfromtxt('./1/0000_distance.csv',dtype='<U32',delimiter=',')
#print(a)
#在名称前加入一行，留出表头位置
pheno_names=np.array(a[:,0])
k=np.array('diagonal')
l=k.reshape(1,1)
dia=l[:,0]
pheno_names=np.hstack((dia,pheno_names))
#print(pheno_names)
phenotype_final=np.zeros((172,1))
#将每个csv中的距离加上样本编号按列逐个拼接在一起
for p in phenotype:
    #print(p)
    pheno=np.genfromtxt(p,dtype='<U32',delimiter=',')
    pheno=pheno[:,1]
    #提取样本编号
    people=p.split('_')[0]
    #print(people)
    pheno=np.hstack((people,pheno))
    pheno=np.array(pheno)
    #print(pheno)
    phenotype_final=np.column_stack((phenotype_final,pheno))

phenotype_final=np.array(phenotype_final)
#将距离矩阵与名称矩阵按列拼接
final=np.column_stack((pheno_names,phenotype_final))
#删除多出的“0.0“列
final = np.delete(final,1,axis=1)
#保存为最终的csv文件
np.savetxt('distance_final.csv',final,delimiter=',',fmt = '%s')