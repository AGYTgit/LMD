#!/bin/zsh

json_array1_2='[
  {"id": 1, "monitor": "DP-1"},
  {"id": 2, "monitor": "DP-1"},
  {"id": 3, "monitor": "DP-1"},
  {"id": 4, "monitor": "DP-1"},
  {"id": 5, "monitor": "DP-1"},
  {"id": 6, "monitor": "HDMI-A-1"},
  {"id": 7, "monitor": "HDMI-A-1"},
  {"id": 8, "monitor": "HDMI-A-1"},
  {"id": 9, "monitor": "HDMI-A-1"},
  {"id": 10, "monitor": "HDMI-A-1"}
]'

json_array2_2='[
  {"id": 1, "window_count": 3, "active": false},
  {"id": 2, "window_count": 2, "active": false},
  {"id": 5, "window_count": 1, "active": false},
  {"id": 7, "window_count": 3, "active": false}
]'

monitor='DP-1'

workspaces_all=$(hyprctl workspacerules -j | jq -c '[.[] | select(.monitor == "'"$monitor"'") | {id: .workspaceString | tonumber, monitor: .monitor}]')

active_workspace=$(hyprctl activeworkspace -j | jq -c)
workspaces_extended=$(hyprctl workspaces -j | jq -c '[.[] | select(.monitor == "'"$monitor"'" and .monitorID == '"$active_workspace.monitorID"') | {
	id: .id,
	monitor: .monitor,
	window_count: .windows,
	active: (.id == '"$active_workspace.id"')
}]')


echo $workspaces_all
echo $workspaces_extended

# Get the highest id from the second array
highest_id=$(echo "$workspaces_extended" | jq 'map(.id) | max')

# Create a sequence of ids from 1 to the highest id in the format {"id": X}
ids=$(seq 1 $highest_id | jq -Rc '[split("\n")[] | select(length > 0) | {id: ("id:" + .)}]')

echo $ids

# Merge the two arrays, filling in missing ids
combined=$(echo "$json_array1 $json_array2 $ids" | jq -s '
    [
        .[2][] as $id_num |
        (
            .[0][] | select(.id == $id_num) | {
                id: .id,
                monitor: .monitor
            }
        ) as $from_first |
        (
            .[1][] | select(.id == ($id_num | tonumber)) | {
                id: (.id | tostring),
                window_count: .window_count,
                active: .active
            }
        ) as $from_second |
        ($from_first // {id: $id_num, monitor: "DP-1"}) * ($from_second // {window_count: 0, active: false})
    ]
')

#echo "$json_array2"
echo "$combined"
