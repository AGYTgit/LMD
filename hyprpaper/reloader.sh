#!/bin/zsh

CONFIG_PATH="$HOME/.dotfiles/LMD-dotfiles/hyprpaper"

trap "killall hyprpaper" INT TERM

while true; do
    hyprpaper -c $CONFIG_PATH/hyprpaper.conf &
    inotifywait -e modify ${CONFIG_PATH}
    killall hyprpaper
done
