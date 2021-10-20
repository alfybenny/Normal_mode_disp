#!/bin/bash

# COMMAND_LINE_VARIABLES
#       * Adding command line variables
#       * i: input file
#       * n: Desired frequency mode
# COMMAND_LINE_VARIABLES

while getopts a:b: flag
do
    case "${flag}" in
        a) file1=${OPTARG};;
        b) file2=${OPTARG};;
    esac
done

paste -d " " ${file1} ${file2} > merge.xyz
