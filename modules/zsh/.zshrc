source "/home/$USER/.dotfiles/LMD/variables/path.sh"

eval "$(starship init zsh)"

alias l="ls -la"
alias q="cd .."

bindkey "^h" backward-char
bindkey "^j" down-line-or-history
bindkey "^k" up-line-or-history
bindkey "^l" forward-char

bindkey "^;" clear-screen
