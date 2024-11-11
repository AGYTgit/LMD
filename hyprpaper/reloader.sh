#!/bin/zsh

CONFIG_PATH="$HOME/.dotfiles/LMD-dotfiles/hyprpaper"

trap "kill $HYPRPAPER_PID; exit" SIGTERM

while true; do
    hyprpaper -c "$CONFIG_PATH/hyprpaper.conf" &
	HYPRPAPER_PID=$!

    inotifywait -e modify "$CONFIG_PATH/hyprpaper.conf" "$CONFIG_PATH/wallpapers"

    kill $HYPRPAPER_PID
done
