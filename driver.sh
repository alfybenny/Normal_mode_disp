#!/bin/bash

# COMMAND_LINE_VARIABLES
#       * Adding command line variables
#       * i: input file ### WARNING: Dont include .log in the input
#       * n: Desired frequency mode
# COMMAND_LINE_VARIABLES

while getopts "i:n:m:" flag
do
    case "${flag}" in
        i) logfile=${OPTARG};;
        n) nthfreq=${OPTARG};;
	m) nthfreq2=${OPTARG};;
    esac
done

# frequency generation---------------------------
# frequency 1
./data.sh -i ${logfile}.log -n ${nthfreq}
mv freq.log freq1.log
# frequency 2
#./data.sh -i ${logfile}.log -n ${nthfreq2}
#mv freq.log freq2.log

# coordinate generation--------------------------
./atomless.sh -i ${logfile}.xyz

mkdir out #Folder to store the output
# Eigenvector displacement-----------------------
# For 1D problem---------------------------------
python3 displace.py 1D freq1.log freq1.log opt.xyz -1 0.1 3
# For 2D problem---------------------------------
# python3 displace.py 2D freq1.log opt.xyz freq2.log -1 0.1 2

# .com file generation---------------------------
cp atommerge.sh out/ # Copying naccessary files to output file
cp atom.xyz out/
cd out/

for i in $(seq -f "%1.1f" 0 0.1 4)
do
	./atommerge.sh -a atom.xyz -b ${i}
done

<< 'COMMENT'
for i in $(seq -f "%1.1f" 0 0.1 3)
do
	for j in $(seq -f "%1.1f" 0 0.1 3)
	do
		./atommerge.sh -a atom.xyz -b ${i}_${j} 
	done
done
COMMENT

rm atommerge.sh *.xyz # Cleaning output folder
cd ..
