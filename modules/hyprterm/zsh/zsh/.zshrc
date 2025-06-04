unsetopt PROMPT_SP

source "$HOME/.dotfiles/LMD/variables/path.env"

alias l="ls -la"
alias q="cd .."
alias t="tree -aI .git"

bindkey "^h" backward-char
bindkey "^j" down-line-or-history
bindkey "^k" up-line-or-history
bindkey "^l" forward-char
bindkey ";" clear-screen

eval "$(starship init zsh)"
