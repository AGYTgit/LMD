#!/bin/zsh

CONFIG_PATH="${HOME}/.dotfiles/LMD-dotfiles/waybar"

trap "killall ${WAYBAR_PID}; exit" SIGTERM

while true; do
	THEME_PATH="themes/$(cat ${CONFIG_PATH}/current-theme.txt)"

    waybar -c "${CONFIG_PATH}/${THEME_PATH}/config.jsonc" -s "${CONFIG_PATH}/${THEME_PATH}/style.css" &
	WAYBAR_PID=$!

    inotifywait -e modify,create,move,delete "${CONFIG_PATH}/current-theme.txt" "${CONFIG_PATH}/${THEME_PATH}"

    kill ${WAYBAR_PID}
done
