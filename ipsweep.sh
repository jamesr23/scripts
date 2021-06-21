#! /bin/bash

if [ $# -lt 1 ]; then
    echo "missing argument: host, using 192.168.1 instead"
    host="192.168.1"
else
    host=$1
fi

for ip in {1..253}; do
    ping $host.$ip -c 1 | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
done
