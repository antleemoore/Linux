#!/bin/bash
echo -n "Please enter a port: "
read port
sudo kill $(sudo lsof -t -i:$port)
