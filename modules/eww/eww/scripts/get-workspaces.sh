#!/bin/zsh

monitor=$1
reverse=$2

prev_state=""
get_workspaces() {
    current_state=$(./scripts/get-workspaces "$monitor" "$reverse")

    if [[ "$current_state" != "$prev_state" && "$current_state" != "[]" ]]; then
        echo "$current_state"
        prev_state="$current_state"
    fi
}

get_workspaces

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
	get_workspaces
done


