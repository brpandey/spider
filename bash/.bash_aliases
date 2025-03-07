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

# aliases for multiple directory listing commands
alias la='ls -Alh'                # show hidden files
alias ls='ls -aFh --color=always' # add colors and file type extensions
alias lx='ls -lXBh'               # sort by extension
alias lk='ls -lSrh'               # sort by size
alias lc='ls -ltcrh'              # sort by change time
alias lu='ls -lturh'              # sort by access time
alias lr='ls -lRh'                # recursive ls
alias lt='ls -ltrh'               # sort by date
alias lw='ls -xAh'                # wide listing format
alias ll='ls -Fls'                # long listing format
alias labc='ls -lap'              # alphabetical sort
alias lf="ls -l | egrep -v '^d'"  # files only
alias ldir="ls -l | egrep '^d'"   # directories only
alias lla='ls -Al'                # List and Hidden Files
alias las='ls -A'                 # Hidden Files

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
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
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
        ip addr show wlan0 | grep "inet " | awk '{print $2}' | cut -d/ -f1
    else
        echo -n "Internal IP: "
        ifconfig wlan0 | grep "inet " | awk '{print $2}'
    fi

    # External IP Lookup
    echo -n "External IP: "
    curl -s ifconfig.me
}

# docker aliases
alias dockerk='docker kill $(docker ps -aq) > /dev/null 2>&1'
alias dockerr='docker rm -f $(docker ps -aq) > /dev/null 2>&1'
alias dcp='docker-compose ps'
alias dcu='docker-compose up -d postgres kafka zookeeper'

alias sqlstop='sudo service postgresql stop'

alias livebook='/home/brpandey/.asdf/installs/elixir/1.15.3-otp-26/.mix/escripts/livebook'

#######################################################
# OTHER ALIASES
#######################################################

alias plexstart='sudo systemctl start plexmediaserver.service'
alias plexstop='sudo systemctl stop plexmediaserver.service'
