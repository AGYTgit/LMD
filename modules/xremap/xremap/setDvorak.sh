#!/bin/bash

declare DVORAK_ACTIVE=$1

if [[ -n $DVORAK_ACTIVE ]]; then
    systemctl --user start xremap-dvorak
else
    systemctl --user stop xremap-dvorak
fi
