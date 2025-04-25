#!/bin/zsh

source $HOME/.zshrc

configPath="$DOTFILES/$MODULES/audio-manager/config"
sinkMutePath="$configPath/sink-mute"
sourceMuteFile="$configPath/source-mute"

getSinkMuteState() {
    cat "$sinkMutePath" | tr -d '\n'
}

getSourceMuteState() {
    cat "$sourceMuteFile" | tr -d '\n'
}

currentSinkMuteState=$(getSinkMuteState)
currentSourceMuteState=$(getSourceMuteState)

getAllSinks() {
    pactl list sinks short | awk '{print $2}'
}

getAllSources() {
    pactl list sources short | awk '{print $2}'
}

applySinkMute() {
    sinkMuteState=$(getSinkMuteState)

    if [[ "$sinkMuteState" != "$currentSinkMuteState" ]]; then
        currentSinkMuteState="$sinkMuteState"
        if [[ "$sinkMuteState" == 1 ]]; then
            getAllSinks | while IFS= read -r sink; do
                pactl set-sink-mute "$sink" 1
            done
        else
            getAllSinks | while IFS= read -r sink; do
                pactl set-sink-mute "$sink" 0
            done
        fi
    fi
}

applySourceMute() {
    sourceMuteState=$(getSourceMuteState)

    if [[ "$sourceMuteState" != "$currentSourceMuteState" ]]; then
        currentSourceMuteState="$sourceMuteState"
        if [[ "$sourceMuteState" == 1 ]]; then
            getAllSources | while IFS= read -r source; do
                pactl set-source-mute "$source" 1
            done
        else
            getAllSources | while IFS= read -r source; do
                pactl set-source-mute "$source" 0
            done
        fi
    fi
}

while true; do
    applySinkMute
    applySourceMute

    inotifywait -e modify "$sinkMutePath" "$sourceMuteFile"
done
