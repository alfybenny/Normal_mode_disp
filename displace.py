# Author: Alfy Benny
# A python module for adding the coordinate matrix with the eigenvectors of selected frequency
# CORE FUNC: Take two matrix files and do addition between them

import numpy as np
import math
import argparse

# COMMAND_LINE_ARGUMENTS---------------------------------------------------------------------------
# SOURCE: https://www.youtube.com/watch?v=cdblJqEUDNo
parser = argparse.ArgumentParser(description = 'Arguments for defining the coefficients')
parser.add_argument('file1', type = str, help = 'File containing first matrix')
parser.add_argument('file2', type = str, help = 'File containing second matrix')
parser.add_argument('scale_upto', type = float, help = 'The highest coefficient of vibrational displacement required')
parser.add_argument('scale_step', type = float, help = 'The step size for interating from 0 to "scale_upto"')
args = parser.parse_args()

# Importing the extracted eigenvectors into a matrix-----------------------------------------------
## UPGRADE: Use functions instead

def create_matrix(filename):
# SOURCE: https://stackoverflow.com/questions/7618858/how-to-to-read-a-matrix-from-a-given-file
    with open(filename, 'r') as f:
        matrix = [[float(num) for num in line.split(',')] for line in f if line.strip() != ""]
    return matrix

# Converting string matrix to float with numpy
freq = np.array(create_matrix(args.file1))
coor = np.array(create_matrix(args.file2))

#--------------------------------------------------------------------------------------------------
# SCALING------------------------------------------------------------------------------------------
# Scaling the eigenvector so that we can simulate the vibration
# Range creation
start = -1 * args.scale_upto
step = args.scale_step
stop = args.scale_upto + step

iterate_range = np.arange(start, stop, step)
# Rounding_off
iterate_range = np.round(iterate_range, 6).tolist()

#--------------------------------------------------------------------------------------------------
# ADDING-------------------------------------------------------------------------------------------
# Addition of matrix with scaled matrix for all coefficients
for i in iterate_range:
    print(np.add(coor, i * freq))

#--------------------------------------------------------------------------------------------------

# Exporting to .csv
disp = np.add(freq, coor)
np.savetxt("out.csv", disp, delimiter= " ", fmt = '%10.5f')




