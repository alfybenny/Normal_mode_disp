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
./data.sh -i ${logfile}.log -n ${nthfreq2}
mv freq.log freq2.log

# coordinate generation--------------------------
./atomless.sh -i ${logfile}.xyz

# Eigenvector displacement-----------------------
mkdir out #Folder to store the output
python3 displace.py freq1.log opt.xyz freq2.log 1 0.1

# .com file generation---------------------------
cp atommerge.sh out/ # Copying naccessary files to output file
cp atom.xyz out/
cd out/

for i in $(seq -f "%1.1f" 0 0.1 2)
do
	for j in $(seq -f "%1.1f" 0 0.1 2)
	do
		./atommerge.sh -a atom.xyz -b ${i}_${j} 
	done
done

rm atommerge.sh *.xyz # Cleaning output folder
cd ..
