eval "$(starship init zsh)"

source "$HOME/.dotfiles/LMD/variables/path.sh"

alias l="ls -la"
alias q="cd .."

alias t="tree -aI .git"

bindkey "^h" backward-char
bindkey "^j" down-line-or-history
bindkey "^k" up-line-or-history
bindkey "^l" forward-char

bindkey ";" clear-screen

export __GL_SYNC_TO_VBLANK=0
