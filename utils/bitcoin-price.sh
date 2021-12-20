#!/bin/sh
a=$(coinmon -f btc | grep BTC | awk '{print $6}')
while [ -z "$a" ]
do
    a=$(coinmon -f btc | grep BTC | awk '{print $6}')
done
echo $1 BTC: \$$a
