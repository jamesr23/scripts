#!/bin/bash

# use printf for utf-8 characters
vline="\u2503"
hline="\u2501"
sline="\u2523"
cline="\u2517"

dir=.

if test -d "$1"; then
    dir=$1
fi

iter() {

    if [ -z "$(ls $1)" ]; then
        return
    fi

    local paths=($1/*)

    for path in ${paths[@]}; do

        if [ $path == "${paths[-1]}" ]; then
            printf "$2$cline$hline$hline$hline$(basename $path)\n"
        else
            printf "$2$sline$hline$hline$hline$(basename $path)\n"
        fi

        if [ -d $path ]; then
            if [ $path == "${paths[-1]}" ]; then
                iter $path "$2    "
            else
                iter $path "$2$vline   "
            fi
        fi
    done
}

echo $dir
iter $dir ""
