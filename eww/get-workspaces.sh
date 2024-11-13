#!/bin/zsh

monitor=$1

if [[ "$monitor" == "0" ]]; then
  	hyprctl workspaces -j | jq -c '
  		map(select(.monitorID == 0) | {id: .id | tostring, current: false})
	'
elif [[ "$monitor" == "1" ]]; then
  	hyprctl workspaces -j | jq -c '
    	map(select(.monitorID == 1) | {id: .id | tostring, current: false})
  	'
else
  	echo "$monitor is not a valid monitorID"
  	exit 1
fi



#spaces (){
#  WORKSPACE_WINDOWS=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries')
#  seq 1 10 | jq --argjson windows "${WORKSPACE_WINDOWS}" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)})'
#}
#
#spaces
#socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
#  spaces
#done
