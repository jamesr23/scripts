#!/bin/bash

IN="/home/$(whoami)/tmp/file-sorter"
OUT="/home/$(whoami)/tmp/file-sorter-out"

mkdir -p $OUT

if ! test -d $IN || ! test -d $OUT; then
    echo "INDIR or OUTDIR is invalid"
fi

for file in $IN/*; do
    if test -f $file; then
        extension="${file##*.}"
        [[ $extension == *"/"* ]] && extension="other"
        echo "moving $file -> $OUT/$extension"
        mkdir -p $OUT/$extension
        mv $file $OUT/$extension
    fi
done
