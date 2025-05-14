eval "$(starship init zsh)"

source "$HOME/.dotfiles/LMD/variables/path.env"

# export DOTFILES="$HOME/.dotfiles"
# export MODULES="modules"
# export SCRIPTS="scripts"
# export VARIABLES="variables"

alias l="ls -la"
alias q="cd .."

alias t="tree -aI .git"

bindkey "^h" backward-char
bindkey "^j" down-line-or-history
bindkey "^k" up-line-or-history
bindkey "^l" forward-char

bindkey ";" clear-screen
