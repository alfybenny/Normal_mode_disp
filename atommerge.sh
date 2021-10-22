#!/bin/bash

# COMMAND_LINE_VARIABLES
#       * Adding command line variables
#       * a: filename1
#       * b: filename2
# COMMAND_LINE_VARIABLES

while getopts a:b: flag
do
    case "${flag}" in
        a) file1=${OPTARG};;
        b) file2=${OPTARG};;
    esac
done

# .com file generation
echo "%nprocshared=28
%mem=128GB
%chk=${file2}.chk
# td(Nstates=20) cam-b3lyp/tzvp

${file2}

0 1
$(paste -d " " ${file1} ${file2}.xyz)

" > ${file2}.com

