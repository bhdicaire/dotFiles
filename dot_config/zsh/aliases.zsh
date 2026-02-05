#!/usr/bin/env zsh

# +--------+
# | System |
# +--------+

alias shutdown='sudo shutdown now'
alias restart='sudo reboot'

# +------------+
# | NAVIGATION |
# +------------+
alias -g ...='../..'
alias -g ....='../../..'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias t="tree -L 1 --dirsfirst -shup"
alias t2="tree -L 2 --dirsfirst"
alias t3="tree -L 2 --dirsfirst"
alias ls=eza
alias ll="eza -la --color=always --icons --group-directories-first"
alias bigf= 'find / -xdev -type f -size +500M'  # display "big" files > 500M
alias doc="$HOME/Documents"
alias dl="$HOME/Downloads"

# +----------+
# | SHORTCUT |
# +----------+
alias %=' '	# commands starting with % for pasting from web
alias a="alias"
alias j="jobs"
alias md='mkdir -p'
alias pbc='pbcopy'
alias pbp='pbpaste'
alias rd=rmdir
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ssh!='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'

# +-----------+
# |IP ADDRESS |
# +-----------+
alias IP="ipconfig getifaddr en0"
alias publicIP="dig +short myip.opendns.com @resolver1.opendns.com"
alias localIP='ifconfig -a | grep "inet " | grep broadcast | awk "{ print $2 }"'
alias whois="whois -h whois-servers.net"
