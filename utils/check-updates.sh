#!/bin/bash
check=$(checkupdates | wc -l)
echo "$1 $check"
