#######################################################
# GENERAL ALIASES
#######################################################
# To temporarily bypass an alias, we precede the command with a \
# EG: the ls command is aliased, but to use the normal ls command you would type \ls
# Also to unset an alias that has already been set in the session
# use unalias

alias open='xdg-open'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# alias to show the date
alias da='date "+%Y-%m-%d %A %T %Z"'

# aliases to modified commands
alias cp='cp -i'
alias mv='mv -i'
alias bat='batcat'

if command -v trash &>/dev/null; then
    alias rm='trash -v'
else
    alias rm='rm -i' # fallback to interactive remove
fi

alias mkdir='mkdir -p'
alias less='less -R'

# Change directory aliases
alias home='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

###########################################################
# eza
###########################################################

alias ls='eza'    # Use eza instead of ls for basic directory listings
alias ll='eza -l' # Detailed listing with permissions, owner, and size

alias la='eza -a'  # List all files, including hidden files (those starting with a dot)
alias lh='eza -lh' # Display file sizes in a human-readable format (KB, MB, etc.)

alias lla='eza -la'  # Detailed listing with permissions, owner, and size
alias lah='eza -lha' # List all files (including hidden), with detailed info and human-readable sizes

alias l1='eza --oneline' # Display file listing one one column

# Tree-like view (similar to ls -R)
alias tree='eza --tree'       # Show files and directories in a recursive, tree-like format
alias treel='eza -l --tree'   # Show long listing files and directories in a recursive, tree-like format
alias treea='eza -a --tree'   # Show all files w/ long listing file and directories in a recursive, tree-like format
alias treela='eza -la --tree' # Show all files w/ long listing file and directories in a recursive, tree-like format

alias li='eza --icons' # Show files with icons (useful with terminal font that supports icons)

alias lsd='eza --only-dirs'         # Show only directories, no files
alias lsdr='eza --only-dirs --tree' # Show only directories and subdirectories recursively

alias lsg='eza --git --grid' # Show files with Git status (added, modified, etc.) if inside a Git repo
alias lsf='eza --only-files' # Show only files, no directories

alias lse='eza -l --sort=extension' # Sort files by extension

alias lss='eza -l --reverse --sort=size' # Reverse time sort
alias lss2='eza -l --sort=size'          # Sort files by size, showing the largest files first

alias lst='eza -l --color=always --sort=time' # Display a colorful listing, sorted by file modification time

# Search command line history
alias h="history | grep "

# Search running processes
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# To see if a command is aliased, a file, or a built-in command
alias checkcommand="type -t"

# Show open ports
alias openports='netstat -nape --inet'

# aliases for safe and forced reboots
alias rebootsafe='sudo shutdown -r now'

# aliases to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias mountedinfo='df -hT'

# aliases for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

#######################################################
# DEV ALIASES
#######################################################

alias version='lsb_release -a'

# IP address lookup
alias whatismyip="whatsmyip"
function whatsmyip() {
    # Internal IP Lookup.
    if command -v ip &>/dev/null; then
        echo -n "Internal IP: "
        ip addr show wlo1 | grep "inet " | awk '{print $2}' | cut -d/ -f1
    else
        echo -n "Internal IP: "
        ifconfig wlo1 | grep "inet " | awk '{print $2}'
    fi

    # External IP Lookup
    echo -n "External IP: "
    curl -s ifconfig.me
}

# docker aliases
alias dstart='sudo systemctl start docker'
alias drestart='sudo service docker restart'
alias dstop='sudo systemctl stop docker'

alias dkill='docker kill $(docker ps -aq) > /dev/null 2>&1'
alias dremove='docker rm -f $(docker ps -aq) > /dev/null 2>&1'

alias dstatus='sudo systemctl status docker'
alias dps='docker ps'

alias livebook='/home/brpandey/.asdf/installs/elixir/1.15.3-otp-26/.mix/escripts/livebook'

#######################################################
# OTHER ALIASES
#######################################################

alias plexstart='sudo systemctl start plexmediaserver.service'
alias plexstop='sudo systemctl stop plexmediaserver.service'
