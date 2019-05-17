# -*- coding: utf-8 -*-
"""
Created on Wed May 15 16:35:35 2019

@author: Demon
"""
#加载所需包
from matplotlib.path import Path
import pandas as pd
import numpy as np
import glob
import os
from math import *

a=np.genfromtxt("C:/Users/dell/Desktop/test.csv",dtype='<U32',delimiter=',')
c=a[0]
for i in range(1,20):
    b=a[i:760:19]
    print(str(b[1,2]))
    d=np.vstack((c,b))
    #f=open(b[1,2]+'.csv','w')
    np.savetxt(str(b[1,2])+'.csv',d,delimiter=',',fmt = '%s')
    #f.write(unicode(d))
    #f.close()