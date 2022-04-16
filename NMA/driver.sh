#!/bin/bash

# For M = 3N-6 vibrational modes


logfile=oHBA

for i in $(seq -f "%1.0f" 1 1 39)
do
	./data.sh -i ${logfile}.log -n ${i}
done
