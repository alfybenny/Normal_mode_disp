#!/bin/bash
# Author: Alfy Benny
# A module for removing the atom name coloumn from xyz file

#awk '{printf "%12s %12s %12s\n", $2, $3, $4}' py101_opt.xyz > opt.xyz

awk '{print $2","$3","$4}' py101_opt.xyz > opt.xyz
awk '{print $1}' py101_opt.xyz > atom.xyz


