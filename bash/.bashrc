#!/usr/bin/env bash
iatest=$(expr index "$-" i)

#######################################################
# STARTUP
#######################################################

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#######################################################
# EXPORTS
#######################################################

# Disable the bell
if [[ $iatest -gt 0 ]]; then bind "set bell-style visible"; fi

# Expand the history size
export HISTFILESIZE=5000
export HISTSIZE=1000
export HISTTIMEFORMAT="%F %T" # add timestamp to history

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# set up XDG folders
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest -gt 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest -gt 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# Set the default editor
if command -v nvim &>/dev/null; then
    export EDITOR=nvim
    export VISUAL=nvim
else
    export EDITOR=vim
    export VISUAL=vim
fi

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#######################################################
# SPECIAL FUNCTIONS
#######################################################
# Extracts any archive(s) (if unp isn't installed)
extract() {
    for archive in "$@"; do
        if [ -f "$archive" ]; then
            case $archive in
            *.tar.bz2) tar xvjf $archive ;;
            *.tar.gz) tar xvzf $archive ;;
            *.bz2) bunzip2 $archive ;;
            *.rar) rar x $archive ;;
            *.gz) gunzip $archive ;;
            *.tar) tar xvf $archive ;;
            *.tbz2) tar xvjf $archive ;;
            *.tgz) tar xvzf $archive ;;
            *.zip) unzip $archive ;;
            *.Z) uncompress $archive ;;
            *.7z) 7z x $archive ;;
            *) echo "don't know how to extract '$archive'..." ;;
            esac
        else
            echo "'$archive' is not a valid file!"
        fi
    done
}

# Copy file with a progress bar
cpp() {
    set -e
    strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
        awk '{
        count += $NF
        if (count % 10 == 0) {
            percent = count / total_size * 100
            printf "%3d%% [", percent
            for (i=0;i<=percent;i++)
                printf "="
            printf ">"
            for (i=percent;i<100;i++)
                printf " "
            printf "]\r"
        }
    }
    END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}

# Goes up a specified number of directories  (i.e. up 4)
up() {
    local d=""
    limit=$1
    for ((i = 1; i <= limit; i++)); do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}

# asdf used for erlang/elixir primarily
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# rust env
. $HOME/.cargo/env

export PATH="$PATH:/home/brpandey/Workspace/elixir/elixir-ls/release"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:/opt/zig-linux-x86_64-0.14.0-dev.3388+e0a955afb/"

eval "$(starship init bash)"       # custommize prompt line
eval "$(zoxide init bash)"         # improve dir navigation
source ~/.local/share/blesh/ble.sh # syntax highlight, autocompletion
