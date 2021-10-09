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
        n) nthfreq=${OPTARG};;
    esac
done


#----------------------------------------------------------------------------------------------------------------------

# Gaussian log file
file=${logfile}

# No. of atoms
Na=42
# No. of frequencies
FreqNo=$(expr 3 \* ${Na} - 6)

# Exit status if user inputs insensible index for frequency mode
if [[ ${nthfreq} -gt ${Na} ]]
then
	echo INPUT ERROR: There are only ${FreqNo} normal modes for the molecule. Re-enter a valid number n designating nth frequency mode.
	exit
fi
#----------------------------------------------------------------------------------------------------------------------


# Frequency data from Gaussian-----------------------------------------------------------------------------------------
  # The above part (Number of frequency, Symmetry, Red. masses, IR Inten)
grep -r -i -B 5 "IR Inten    --" ${file} > freq_header.txt

# The eigenvectors (dx, dy, dz) for each frequency modes
grep -r -i -A $(expr $Na + 1) "IR Inten    --" ${file} > freq_eigvec_1.txt # NOTE: ${Na} + 1 where extra line is header
sed '/IR Inten    --/d' freq_eigvec_1.txt > freq_eigvec.txt
rm freq_eigvec_1.txt

# Grepping till the ${nthfreq} with each one having ${Na} atoms and tailing the last ${Na} sets of data\
# SOURCE "https://unix.stackexchange.com/questions/115224/print-line-after-nth-occurrence-of-a-match"

	# WARNING: Only if nthfreq > 3 and nthfreq is not divisible by 3-----------------------------------------------


	# The following circus is because of the shitty log file gaussian gives
	# Note that gaussian prints freqencies as 3 sets of coloumns

checkdivby3=$(expr ${nthfreq} % 3)
	
if [[ ${nthfreq} -le 3 ]]
then
	row=1
	coloumn=${nthfreq}
elif [[ ${checkdivby3} -eq 0 ]]
then
	div=$(expr ${nthfreq} / 3)
	row=$(expr ${div} + 1)
	mult=$(expr 3 \* ${div})
	coloumn=3
else
	div=$(expr ${nthfreq} / 3)
	row=$(expr ${div} + 1)
	mult=$(expr 3 \* ${div})
	coloumn=$(expr ${nthfreq} % ${mult})
fi


	# Getting the required row of 3 sets of eigenvectors from gaussian
grep -A ${Na} -m ${row} 'Atom' freq_eigvec.txt | tail -n ${Na} > ${row}section.txt 

	# Isolating the eigenvectors of nth frequency

if [[ ${coloumn} -eq 1 ]]
then
	awk1=$(expr ${coloumn} + 2)
	awk2=$(expr ${coloumn} + 3)
	awk3=$(expr ${coloumn} + 4)
elif [[ ${coloumn} -eq 2 ]]
then
	awk1=$(expr ${coloumn} + 4)
	awk2=$(expr ${coloumn} + 5)
	awk3=$(expr ${coloumn} + 6)
else
	awk1=$(expr ${coloumn} + 6)
	awk2=$(expr ${coloumn} + 7)
	awk3=$(expr ${coloumn} + 8)
fi


# SOURCE: "https://stackoverflow.com/questions/19075671/how-do-i-use-shell-variables-in-an-awk-script"
awk -v a="$awk1" -v b="$awk2" -v c="$awk3" '{print $a " " $b " " $c " "}' ${row}section.txt > ${nthfreq}.log


rm *txt

# Code execution success!!


