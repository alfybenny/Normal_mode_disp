#!/bin/bash

# Gaussian log file
file="py101_opt.log"

# No. of atoms
Na=42

# Frequency data from Gaussian
  # The above part (Number of frequency, Symmetry, Red. masses, IR Inten)
grep -r -i -B 5 "IR Inten    --" ${file} > freq_header.txt
  # The eigenvector (x, y, z for Na atoms)
grep -r -i -A $Na "IR Inten    --" ${file} > freq_eigvec_1.txt
sed '/IR Inten    --/d' freq_eigvec_1.txt > freq_eigvec.txt
rm freq_eigvec_1.txt
