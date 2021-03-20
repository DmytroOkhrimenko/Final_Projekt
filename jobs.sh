#!/bin/bash 

# set up environmental variables 
export GAUSS_SCRDIR=/home/ubuntu/scratch
export GAUSS_EXEDIR=/home/ubuntu/gaussian/g03
export g03root=/home/ubuntu/gaussian
export PATH=$PATH:$GAUSS_EXEDIR
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GAUSS_EXEDIR

g03 $1






