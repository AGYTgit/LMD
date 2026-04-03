unsetopt PROMPT_SP

source "$HOME/.dotfiles/LMD/variables/path.env"

alias bc="bluetoothctl"

alias ff="fastfetch"
alias l="ls -la --color -h --group-directories-first"
alias q="cd .."
alias t="tree -aCI .git --dirsfirst"
alias tt="t -L 2"
alias lines="find . -type f -name '*.c' -o -name '*.h' | xargs wc -l"

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
