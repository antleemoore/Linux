#!/bin/sh
a=$(newsboat -x print-unread | awk '{ if($1>0) print $1}')
if [[ $a == 'Error:' ]]; then
    a="Reading"
fi
echo $1 $a
