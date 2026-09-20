#!/usr/bin/env bash

LOCKFILE="/tmp/autoclicker.lock"

case "$1" in
    start)
        touch "$LOCKFILE"
        while [ -f "$LOCKFILE" ]; do
            ydotool click 0xC0
            sleep 0.01
        done
        ;;
    stop)
        rm -f "$LOCKFILE"
        ;;
esac
