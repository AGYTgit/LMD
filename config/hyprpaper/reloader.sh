#!/bin/zsh

CONFIG_PATH="$HOME/.dotfiles/LMD/hyprpaper"

trap "kill $HYPRPAPER_PID; exit" SIGTERM SIGINT INT TERM

while true; do
    hyprpaper -c "$CONFIG_PATH/hyprpaper.conf" &
	HYPRPAPER_PID=$!

    inotifywait -e modify,create,move,delete "$CONFIG_PATH/hyprpaper.conf" "$CONFIG_PATH/wallpapers"

    kill $HYPRPAPER_PID
done
