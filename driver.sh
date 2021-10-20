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

echo ${logfile}
echo ${nthfreq}
echo ${nthfreq2}

# frequency generation
./data.sh -i ${logfile}.log -n ${nthfreq}
mv freq.log freq1.log
./data.sh -i ${logfile}.log -n ${nthfreq2}
mv freq.log freq2.log

# coordinate generation
./atomless.sh -i ${logfile}.xyz

# Eigenvector displacement
python3 displace.py freq1.log opt.xyz freq2.log 1 0.1

# .com file generation
./atommerge.sh -a atom.xyz -b out.csv
