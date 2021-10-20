#!/bin/bash

# COMMAND_LINE_VARIABLES
#       * Adding command line variables
#       * i: input file ### WARNING: Dont include .log in the input
#       * n: Desired frequency mode
# COMMAND_LINE_VARIABLES

while getopts i:n: flag
do
    case "${flag}" in
        i) logfile=${OPTARG};;
        n) nthfreq=${OPTARG};;
    esac
done

# frequency generation
./data.sh -i ${logfile}.log -n ${nthfreq}

# coordinate generation
./atomless.sh -i ${logfile}.xyz

# Eigenvector displacement
python3 displace.py freq.log opt.xyz 1 0.1

# .com file generation
./atommerge.sh -a atom.xyz -b out.csv
