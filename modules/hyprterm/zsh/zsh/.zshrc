unsetopt PROMPT_SP

source "$HOME/.dotfiles/LMD/variables/path.env"

alias bc="bluetoothctl"

alias ff='clear -x && fastfetch'
alias l="exa -la --git --group-directories-first"
alias q="cd .."
alias t="tree -aCI .git --dirsfirst"
alias tt="t -L 2"

ban() { man "$@" | bat -l man }

bindkey "^h" backward-char
bindkey "^j" down-line-or-history
bindkey "^k" up-line-or-history
bindkey "^l" forward-char

bindkey "^b" backward-word
bindkey "^n" forward-word

bindkey "^" clear-screen

export EDITOR=nvim

export PATH="$HOME/.cargo/bin:$PATH"

eval "$(starship init zsh)"
