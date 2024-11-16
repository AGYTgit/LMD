#!/bin/zsh

monitor=$1
reverse=$2

prev_state=""

# Run the C program and get the workspaces
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
    # Call the compiled get_workspaces program
    current_state=$(./scripts/get-workspaces "$monitor" "$reverse")  # Pass arguments to get_workspaces

    # Compare and output if the state changes and isn't empty
    if [[ "$current_state" != "$prev_state" && "$current_state" != "[]" ]]; then
        echo "$current_state"
        prev_state="$current_state"
    fi
done
