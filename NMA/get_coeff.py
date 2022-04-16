import numpy as np
from matplotlib import pyplot as plt

# import argparse
# import os.path

# parser = argparse.ArgumentParser(description = 'Arguments for defining the coefficients')
# parser.add_argument('no_of_modes', type = int, help = '3n-6 value')
# parser.add_argument('coor_gs', type = int, help = 'ground state geometry')
# parser.add_argument('coor_es', type = int, help = 'excited state geometry')
# args = parser.parse_args()

no_of_modes = 39

def create_matrix(filename):
# SOURCE: https://stackoverflow.com/questions/7618858/how-to-to-read-a-matrix-from-a-given-file
    with open(filename, 'r') as f:
        pre_matrix = [[float(num) for num in line.split(',')] for line in f if line.strip() != ""]
        matrix = np.array(pre_matrix)
        
    return matrix.flatten()

pre_q_list = []

tot_freq = np.arange(1, no_of_modes+1, 1)

for i in tot_freq:
     q_i = create_matrix(str(i)+'.log')
     pre_q_list.append(q_i)
     
q_list = np.array(pre_q_list)

# print(len(q_list))

# STEP 2: Get coorditate difference
coor_gs = create_matrix('opt_gs.xyz')
coor_es = create_matrix('opt_es.xyz')

DEL_COOR = coor_es-coor_gs

c_list = []

for i in range(0, no_of_modes):
    for j in range(0, no_of_modes):
        if j!=i:
            print('mode '+str(i)+' and mode '+str(j)+' dot product is '+str(np.dot(q_list[i], q_list[j])))

for i in range(0, no_of_modes):
    q_i = q_list[i]
    c_i = np.dot(q_i, DEL_COOR)/np.dot(DEL_COOR, DEL_COOR)
    
    c_list.append(c_i)
    
plt.plot(c_list, 'o')
        
    






    



