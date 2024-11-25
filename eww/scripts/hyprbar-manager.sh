#!/bin/zsh

monitor=$1

prev_state=""
get_fullscreen_monitor() {
	current_state=$(hyprctl activeworkspace -j | jq -r "select(.monitor == \"$monitor\") | .hasfullscreen")

    if [[ "$current_state" != "$prev_state" && "$current_state" != "[]" ]]; then
		$(eww close hyprbar)
		if [[ "$current_state" == true ]]; then
			$(eww open hyprbar --screen 0)
		else
			$(eww open hyprbar --screen 1)
		fi

		prev_state="$current_state"
    fi
}

get_fullscreen_monitor

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
	get_fullscreen_monitor
done
