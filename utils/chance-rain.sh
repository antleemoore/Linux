#!/bin/bash
# $HOME/utils/wait-for-internet
weatherreport=$(curl wttr.in/32817)

chancerain=$(echo "$weatherreport" | grep -o '[^ ]*%')
today=$(echo "$chancerain" | perl -pe 's/.*?(\d+% \d+% \d+% \d+%).*/$1/')

var1=$(echo $today | sed 's/%.*//g')
firstchange=$(echo $today |sed 's/^[^%]% //g')
var2=$(echo $firstchange | sed 's/%.*//g')
secondchange=$(echo $firstchange | sed 's/^[^%]% //g')
var3=$(echo $secondchange | sed 's/%.*//g')
thirdchange=$(echo $secondchange | sed 's/.*% //g')
var4=$(echo $thirdchange | sed 's/%.*//g')

max=$(echo $var{1,2,3,4} | tr ' ' '\n' | sort -nr | head -1)
echo "$1 $max%"
