#!/bin/bash

if ! pgrep mpd; then
    exit 0
fi

case $1 in
    toggle)
    mpc toggle
    ;;
    prev)
    mpc prev
    ;;
    next)
    mpc next
    ;;
    *)
    exit 1
    ;;
esac
