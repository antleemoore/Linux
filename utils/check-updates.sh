#!/bin/bash
check=$(checkupdates | wc -l)
if [[ $check -ne 0 ]]; then
    echo $1 $check
fi
