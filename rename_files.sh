#! /bin/bash

name="background_image"

counter=0

dir=.

if test -d $dir; then;
    dir="$1"
fi

cd $dir

echo $(PWD)

if [ $(PWD) != $dir ]; then
    # dont ever fucking forget this again you little shit
    echo "directory is not matching, aborted"
    exit
fi

for file in *; do
    mv $file "tmp_file_name_"$counter
    ((counter++))
done

counter=0

for file in *; do
    mv $file $name$counter".png"
    ((counter++))
done

ls
