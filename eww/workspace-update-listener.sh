#!/bin/zsh

# Listen for workspace change events from Hyprland
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
  while read -r line; do
    # Check if the event is a workspace change
    if [[ "$line" == *"workspace"* ]]; then
      # Trigger EWW to update workspaces when a workspace change is detected
      echo "Workspace changed, triggering EWW update..."

      # Update the primary and secondary workspaces in EWW using the update command
      eww update workspaces-primary
      eww update workspaces-secondary
    fi
  done

