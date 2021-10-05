#!/bin/bash

<< COMMAND_LINE_VARIABLES 
	* Adding command line variables
	* i: input file
	* n: Desired frequency mode
COMMAND_LINE_VARIABLES

while getopts i:n: flag
do
    case "${flag}" in
        i) logfile=${OPTARG};;
        n) nthfreq=${OPTARG};; ##Still not active
    esac
done


# Gaussian log file
file=${logfile} ##"py101_opt.log"

# No. of atoms
Na=42

# Frequency data from Gaussian
  # The above part (Number of frequency, Symmetry, Red. masses, IR Inten)
grep -r -i -B 5 "IR Inten    --" ${file} > freq_header.txt

# The eigenvectors (dx, dy, dz) for each frequency modes
grep -r -i -A $(expr $Na + 1) "IR Inten    --" ${file} > freq_eigvec_1.txt # NOTE: ${Na} + 1 where extra line is header
sed '/IR Inten    --/d' freq_eigvec_1.txt > freq_eigvec.txt
rm freq_eigvec_1.txt

# Grepping till the ${nthfreq} with each one having ${Na} atoms and tailing the last ${Na} sets of data\
# Source "https://unix.stackexchange.com/questions/115224/print-line-after-nth-occurrence-of-a-match"
grep -A ${Na} -m ${nthfreq} 'Atom' freq_eigvec.txt | tail -n ${Na} > ${nthfreq}freq.log 

# WARNING!!! Code is incomplete. ${nthfreq} is only printing the set of eigenvectors in the gaussian log file. 
# Need to awk the x y z as well
# A problem for another day
