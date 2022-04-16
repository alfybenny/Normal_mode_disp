# Author: Alfy Benny
# A python module for adding the coordinate matrix with the eigenvectors of selected frequency
# CORE FUNC: Take two matrix files and do addition between them

import numpy as np
import math
import argparse
import os.path

# COMMAND_LINE_ARGUMENTS---------------------------------------------------------------------------
# SOURCE: https://www.youtube.com/watch?v=cdblJqEUDNo
parser = argparse.ArgumentParser(description = 'Arguments for defining the coefficients')
parser.add_argument('type', type = str, help = '1D or 2D')
parser.add_argument('file1', type = str, help = 'File containing eigenvectors for freq1')  
parser.add_argument('file3', type = str, help = 'File containing eigenvectors of freq2')
parser.add_argument('file2', type = str, help = 'File containing molecular geometry')
parser.add_argument('scale_from', type = float, help = 'for the given frequency, scale backward this much')
parser.add_argument('scale_step', type = float, help = 'The step size for interating from 0 to "scale_upto"')
parser.add_argument('scale_to', type = float, help = 'scale the displacement upto this magnitude')
args = parser.parse_args()

# Importing the extracted eigenvectors into a matrix-----------------------------------------------
## UPGRADE: Use functions instead

def create_matrix(filename):
# SOURCE: https://stackoverflow.com/questions/7618858/how-to-to-read-a-matrix-from-a-given-file
    with open(filename, 'r') as f:
        matrix = [[float(num) for num in line.split(',')] for line in f if line.strip() != ""]
    return matrix

#--------------------------------------------------------------------------------------------------
# SCALING------------------------------------------------------------------------------------------
# Scaling the eigenvector so that we can simulate the vibration
# Range creation
start = args.scale_from
step = args.scale_step
stop = args.scale_to + 1

iterate_range = np.arange(start, stop, step)

# Rounding_off
iterate_range = np.round(iterate_range, 6).tolist()
    
# Converting string matrix to float with numpy
# CASE 1D #------------------
if args.type == '1D':
    freq1 = np.array(create_matrix(args.file1))
    coor = np.array(create_matrix(args.file2))
    
    # ADDING-------------------------------------------------------------------------------------------
    # Addition of matrix with scaled matrix for all coefficients
    for i in iterate_range:
        out1 = np.add(coor, i * 0.6 * freq1)
        ii = round(1 + i, 2)
        path = "out/{}.xyz".format(str(ii))
        np.savetxt(path, out1, delimiter = " ", fmt = '%10.5f')

# CASE 2D #-----------------
elif args.type == '2D':   
    freq1 = np.array(create_matrix(args.file1))
    coor = np.array(create_matrix(args.file2))
    freq2 = np.array(create_matrix(args.file3))
    
    # ADDING-------------------------------------------------------------------------------------------
    # Addition of matrix with scaled matrix for all coefficients
    for i in iterate_range:
        for j in iterate_range:
            
            out1 = np.add(coor, i * 0.6 * freq1)
            out = np.add(out1, j * 0.6 * freq2)
            # Rounding displaced values for file name (for tracking)
            ii = round(1 + i, 2)
            jj = round(1 + j, 2)
            path = "out/{}_{}.xyz".format(str(ii), str(jj))
            np.savetxt(path, out, delimiter = " ", fmt = '%10.5f')

#--------------------------------------------------------------------------------------------------


