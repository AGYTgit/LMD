unsetopt PROMPT_SP

source "$HOME/.dotfiles/LMD/variables/path.env"

alias l="ls -la --color -h --group-directories-first"
alias q="cd .."
alias t="tree -aCI .git --dirsfirst"

bindkey "^h" backward-char
bindkey "^j" down-line-or-history
bindkey "^k" up-line-or-history
bindkey "^l" forward-char
bindkey "^" clear-screen

bindkey "^b" backward-word
bindkey "^n" forward-word

eval "$(starship init zsh)"
