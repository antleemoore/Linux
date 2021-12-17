#!/bin/sh
a=$(newsboat -x print-unread | awk '{ if($1>0) print $1}')
echo $1 $a
