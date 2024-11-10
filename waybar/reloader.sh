#!/bin/zsh

CONFIG_PATH="$HOME/.dotfiles/LMD-dotfiles/waybar" # $HOME/.config/waybar/themes/default/style.css"
THEME_PATH="/themes/default"
trap "killall waybar" EXIT

waybar -c $CONFIG_PATH/$THEME_PATH/config.jsonc -s $CONFIG_PATH/$THEME_PATH/style.css &

while true; do
    inotifywait -e modify ${CONFIG_PATH}/${THEME_PATH}
    killall -SIGUSR2 waybar
done
