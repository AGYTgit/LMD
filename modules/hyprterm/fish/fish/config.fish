set -g fish_greeting ""

source "$HOME/.dotfiles/LMD/variables/path.env"

set -Ux LIBVIRT_DEFAULT_URI qemu:///system

COMPLETE=fish tms | source

alias cp="cp -i"
alias mv="mv -i"
alias bc="bluetoothctl"
alias ff='clear -x && fastfetch'
alias l="exa -laa --git --group-directories-first"
alias q="cd .."
alias t="tree -aCI .git --dirsfirst"
alias tt="t -L 2"
alias tmss="tms switch"

function ban
    man $argv | bat -l man
end

bind \cy accept-autosuggestion

bind \cj history-search-forward
bind \ck history-search-backward
bind \ch backward-char
bind \cl forward-char
bind \cb backward-word
bind \cn forward-word
bind ^ clear-screen

set -gx EDITOR nvim
set -gx PATH "$HOME/.cargo/bin:$PATH"

# Fish color scheme - default theme (terminal colors)
set -gx fish_color_normal normal
set -gx fish_color_autosuggestion brblack
set -gx fish_color_cancel -r
set -gx fish_color_command normal
set -gx fish_color_comment red
set -gx fish_color_cwd green
set -gx fish_color_cwd_root red
set -gx fish_color_end green
set -gx fish_color_error brred
set -gx fish_color_escape brcyan
set -gx fish_color_history_current --bold
set -gx fish_color_host normal
set -gx fish_color_host_remote yellow
set -gx fish_color_operator brcyan
set -gx fish_color_param cyan
set -gx fish_color_quote yellow
set -gx fish_color_redirection cyan --bold
set -gx fish_color_search_match white --background=brblack --bold
set -gx fish_color_selection white --background=brblack --bold
set -gx fish_color_status red
set -gx fish_color_user brgreen
set -gx fish_color_valid_path --underline
set -gx fish_pager_color_description yellow --italics
set -gx fish_pager_color_prefix normal --bold --underline
set -gx fish_pager_color_progress brwhite --background=cyan --bold
set -gx fish_pager_color_selected_background -r

starship init fish | source
