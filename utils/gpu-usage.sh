#!/bin/bash
foo=$(sensors | grep Composite: | sed 's/(.*//' | sed 's/.*+//')  
var=$(nvidia-smi | grep 'MiB /' | cut -d '|' --complement -f-2,4 | sed 's/MiB/ MB/g')
var=${var%|}
var=$(echo ${var} | sed 's/MB//g')
intOne=$(echo ${var} | sed 's/ \/.*//g')
intTwo=$(echo ${var} | sed 's/.*\/ //g')
echo -n $1 
echo -n " "
echo -n $(( intOne * 100 / intTwo))
echo -n "% "
echo -n $foo
# echo -n " "
# echo -n $(sensors | grep 'fan1' | sed 's/ //g' | sed 's/fan1\://' | sed 's/\ *(.*//')
# echo -n " "
# echo -n $(sensors | grep 'fan2' | sed 's/ //g' | sed 's/fan2\://' | sed 's/\ *(.*//')
# echo -n " "
# echo -n $(sensors | grep 'fan3' | sed 's/ //g' | sed 's/fan3\://' | sed 's/\ *(.*//')
