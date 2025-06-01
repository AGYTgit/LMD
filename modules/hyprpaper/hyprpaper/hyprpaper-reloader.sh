#!/bin/zsh

source "$HOME/.zshrc"

CONFIG_DIR="$DOTFILES/modules/hyprpaper/hyprpaper"

while true; do
    hyprpaper -c "$CONFIG_DIR/hyprpaper.conf" &
    HP_PID=$!

    inotifywait -e modify,create,move,delete "$CONFIG_DIR/hyprpaper.conf" "$CONFIG_DIR/wallpapers"

    kill $HP_PID
done
