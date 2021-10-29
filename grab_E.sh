#!/bin/bash

# COMMAND_LINE_VARIABLES
#       * Adding command line variables
#       * e: excited state
#       * m: method
# COMMAND_LINE_VARIABLES

while getopts "e:m:" flag
do
    case "${flag}" in
        e) excited_state=${OPTARG};;
        m) method=${OPTARG};;
    esac
done

touch final.csv

# To print in three coloumns
if [[ ${method} -eq 1 ]]
then
	for i in $(seq -f "%1.1f" 0 0.1 2)
	do
        	for j in $(seq -f "%1.1f" 0 0.1 2)
        	do
                	grep "Excited State   ${excited_state}:" ${i}_${j}.log >> test1.txt
                	echo ${i} >> xaxis.csv
                	echo ${j} >> yaxis.csv
        	done
	done
	awk '{print $5}' test1.txt > test2.txt
	paste -d, xaxis.csv yaxis.csv test2.txt > final_${excited_state}.csv
	rm test2.txt test1.txt xaxis.csv yaxis.csv

# To print as a matrix
elif [[ ${method} -eq 2 ]]
then
	for i in $(seq -f "%1.1f" 0 0.1 2)
	do
        	for j in $(seq -f "%1.1f" 0 0.1 2)
        	do
                	grep "Excited State   ${excited_state}:" ${i}_${j}.log >> test1.txt
        	done

        	awk '{print $5}' test1.txt > ${i}
        	rm test1.txt
	done

	seq -f "%1.1f" 0 0.1 2 > seq.txt
	awk 'BEGIN { ORS = " " } { print }' seq.txt

	paste -d, $(awk 'BEGIN { ORS = " " } { print }' seq.txt) > final_${excited_state}_mat.csv

	for i in $(seq -f "%1.1f" 0 0.1 2)
	do
	        rm ${i}
	done

	rm *txt
fi



