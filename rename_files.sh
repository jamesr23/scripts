#!/bin/bash

name="background_image"
extension=".png"

counter=0

dir=$PWD

if test -d "$1"; then
    dir="$1"
fi

cd $dir

echo "presume renaming in directory $dir on files:"
ls -1

read -p "[y/n]"

if test "$REPLY" = n; then
    echo aborting...
    exit 1
fi

for file in *; do
    mv $file "tmp_file_name_"$counter
    ((counter++))
done

counter=0

for file in *; do
    mv $file $name$counter$extension
    ((counter++))
done

ls
