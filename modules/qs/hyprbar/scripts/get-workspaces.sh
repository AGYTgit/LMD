#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
BINARY_PATH="$SCRIPT_DIR/get-workspaces"

monitor=$1
dynamicVisibility=$2
reverse=$3

SOCKET_PATH=""
for dir in $(ls -dt "/run/user/$(id -u)/hypr/*/" 2>/dev/null); do
    sock="${dir}.socket2.sock"
    if [ -S "$sock" ]; then
        if timeout 0.1 nc -U "$sock" </dev/null &>/dev/null || [ -e "$sock" ]; then
            SOCKET_PATH="$sock"
            break
        fi
    fi
done

if [ -z "$SOCKET_PATH" ]; then
    latest_sig=$(ls -t "/run/user/$(id -u)/hypr/" | head -n 1)
    SOCKET_PATH="/run/user/$(id -u)/hypr/$latest_sig/.socket2.sock"
fi

prev_state=""
get_workspaces() {
    current_state=$("$BINARY_PATH" "$monitor" "$dynamicVisibility" "$reverse")

    if [[ "$current_state" != "$prev_state" && "$current_state" != "[]" ]]; then
        echo "$current_state"
        prev_state="$current_state"
    fi
}

current_state=$("$BINARY_PATH" "$monitor" "$dynamicVisibility" "$reverse")
echo "$current_state"
prev_state="$current_state"

socat -u UNIX-CONNECT:"$SOCKET_PATH" - | while read -r _; do
    get_workspaces
done
