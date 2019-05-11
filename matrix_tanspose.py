# -*- coding: utf-8 -*-
"""
Created on Thu Apr 18 10:35:24 2019

@author: Demon
"""
from matplotlib.path import Path
import pandas as pd
import numpy as np
import glob
import os
from math import *

a=np.genfromtxt('table.csv',dtype='<U32',delimiter=',')
b=np.array(a)
c=np.transpose(b)
print(c)
np.savetxt('t.csv',c,delimiter=',',fmt = '%s')
