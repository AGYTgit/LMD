#!/bin/zsh

monitor=$1

spaces () {
	active_workspace=$(hyprctl activeworkspace -j | jq -c)

	workspaces=$(hyprctl workspaces -j | jq -c '[.[] | select(.monitorID == '"$monitor"' and .monitorID == '"$active_workspace.monitorID"') | {
		id: .id,
		windows: .windows,
		active: (.id == '"$active_workspace.id"')
	}]')

	if [[ "$monitor" == 1 ]]; then
		echo "$workspaces" | jq -c reverse
	else
		echo "$workspaces" | jq -c
	fi
}

prev_state=""

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
	current_state=$(spaces)

	if [[ "$current_state" != "$prev_state" && "$current_state" != "[]" ]]; then
		echo "$current_state"
		prev_state="$current_state"
	fi
done