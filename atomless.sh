#!/bin/bash
# Author: Alfy Benny
# A module for removing the atom name coloumn from xyz file

#awk '{printf "%12s %12s %12s\n", $2, $3, $4}' py101_opt.xyz > opt.xyz
# COMMAND_LINE_VARIABLES
#       * Adding command line variables
#       * i: input file
#       * n: Desired frequency mode ### WARNING: for now n is not active
# COMMAND_LINE_VARIABLES

while getopts i:n: flag
do
    case "${flag}" in
        i) xyzfile=${OPTARG};;
        n) nthfreq=${OPTARG};;
    esac
done

awk '{print $2","$3","$4}' ${xyzfile} > opt.xyz
awk '{print $1}' ${xyzfile} > atom.xyz


