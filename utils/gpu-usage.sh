#!/bin/bash
foo=$(sensors | grep Tccd1: | sed 's/(.*//' | sed 's/.*+//')  
var=$(nvidia-smi | grep 'MiB /' | cut -d '|' --complement -f-2,4 | sed 's/MiB/ MB/g')
var=${var%|}
var=$(echo ${var} | sed 's/MB//g')
intOne=$(echo ${var} | sed 's/ \/.*//g')
intTwo=$(echo ${var} | sed 's/.*\/ //g')
sum=$((intOne*100/intTwo))
echo $1 $sum%
# echo -n $foo
