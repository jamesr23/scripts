#!/bin/bash

IN="/home/$(whoami)/tmp/file-sorter"
OUT="/home/$(whoami)/tmp/file-sorter-out"

mkdir -p $OUT

if ! test -d $IN || ! test -d $OUT; then
    echo "INDIR or OUTDIR is invalid"
fi

for file in $IN/*; do
    if test -f $file; then
        filename="${file%%.*}"
        extension="${file##*.}"
        loc=$extension
        test -z $extension && loc="other"
        echo "moving $file -> $OUT/$loc"
        mkdir -p $OUT/$loc
        mv $file $OUT/$loc
    fi
done
