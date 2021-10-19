# Author: Alfy Benny
# A python module for adding the coordinate matrix with the eigenvectors of selected frequency
# CORE FUNC: Take two matrix files and do addition between them

import numpy as np
import math
import argparse

parser = argparse.ArgumentParser(description = 'Arguments for defining the coefficients')
parser.add_argument('scale_upto', type = float, help = 'The highest coefficient of vibrational displacement required')
parser.add_argument('scale_step', type = float, help = 'The step size for interating from 0 to "scale_upto"')
args = parser.parse_args()

# Importing the extracted eigenvectors into a matrix-----------------------------------------------
## UPGRADE: Use functions instead
# SOURCE: https://stackoverflow.com/questions/7618858/how-to-to-read-a-matrix-from-a-given-file
with open('freq.log', 'r') as f:
    freq = [[float(num) for num in line.split(',')] for line in f if line.strip() != ""]

with open('opt.xyz', 'r') as f:
    coor = [[float(num) for num in line.split(',')] for line in f if line.strip() != ""]

# Converting string matrix to float with numpy
freq = np.array(freq)
coor = np.array(coor)
#--------------------------------------------------------------------------------------------------

# SCALING------------------------------------------------------------------------------------------
# Scaling the eigenvector so that we can simulate the vibration

print(args.scale_upto)
print(args.scale_step) 


disp = np.add(freq, coor)

print(freq)
print(coor)

print(disp)
#m = np.loadtxt('freq.log', dtype = 'f', delimiter=',')
#n = np.loadtxt('opt.xyz', dtype = 'f', delimiter=',')

#print(m)
#print(n)
