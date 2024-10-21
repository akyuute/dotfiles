### Sam's Bash configuration ###
## See also ~/.bash_profile, ~/.inputrc

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi


# Check the window size after each command and,
# if necessary, update LINES and COLUMNS values:
shopt -s checkwinsize

# Use readline vi-mode 
set -o vi

shopt -s hostcomplete
shopt -s globstar


# History control
HISTFILE="$HOME/.bash_history"
HISTSIZE=-1
HISTCONTROL=ignoredups
PROMPT_COMMAND='history -a'
# Append session histories instead of overwriting them:
shopt -s histappend


## Bind Alt+Shift+(-)/(+) to change terminal brightness without Xorg
#bind -x '"\e_":"brightnessctl s 1%- &> /dev/null"'
#bind -x '"\e+":"brightnessctl s 1%+ &> /dev/null"'


# Prompt

#PS1="\e[1;30m\h\e[m \e[0;31m\W\e[0m \e[0;31m$\e[m "
green="\001$(tput setaf 2)\002"
gray="\001$(tput setaf 0; tput bold)\002"
red="\001$(tput setaf 1)\002"
blue="\001$(tput setaf 4)\002"
magenta="\001$(tput setaf 5)\002"
dim="\001$(tput dim)\002"
bold="\001$(tput bold)\002"
reset="\001$(tput sgr0)\002"

#PS1="$green\u@\h" # user@host
#PS1="$bold$gray\h $reset" # hostname
PS1="$magenta@\h $reset" # @hostname
PS1+="$red\W \$$reset " # working-dir $
unset green blue dim reset


# Double terminal font size on a MacBook with a retina display.
# Check that we're not in an X server before attempting to run `setfont`:
#xrdb -query &> /dev/null || setfont -d lat0-16
xrdb -query &> /dev/null || setfont lat0-16


export PS1
export EDITOR=vim
export CLICOLOR=1


# Aliases

alias '...'='cd ../..'
alias '....'='cd ../../..'
alias G='grep --color=auto -v'
alias L='less --use-color'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias less='less --use-color'
alias ls='command ls --color=auto -v'
alias ll='command ls -ll --color=auto -v'
alias lh='command ls -lAh --color=auto -v'
alias la='command ls -lah --color=auto -v'
alias lad='command ls -d --color=auto -v'
alias ld='command ls -lad --color=auto -v'
alias rm='command rm -i'
alias cp='command cp -i'
alias mv='command mv -i'
alias S='systemctl'
alias X='startx'
alias Cd='cd $OLDPWD'
alias bang='poweroff'
alias vimconf='vim $HOME/.config/.vimrc'
alias i3conf='vim $HOME/.config/i3/config'
alias blupill='cmatrix -abC cyan'
alias redpill='cmatrix -aC red'
alias senbonzakura='cmatrix -aC magenta'
