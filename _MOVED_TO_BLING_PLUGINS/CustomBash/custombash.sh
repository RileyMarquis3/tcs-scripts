# ~/.bash_profile: executed by bash(1) for login shells.

umask 002
## The following line is a default parameter; disabled for replacement with a custom implementation.
### PS1='[\h]$ '

## Custom PS1 Implementation - Basic
## PS1='$(whoami)@$(hostname):$(pwd)$'

## Custom PS1 - MoreInfo
PS1="\n\[\033[35m\]\$(/bin/date)\n\[\033[32m\]\w\n\[\033[1;31m\]\u@\h: \[\033[1;34m\]\$(/usr/bin/tty | /bin/sed -e 's:/dev/::'): \[\033[1;36m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files \[\033[1;33m\]\$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\033[0m\] -> \[\033[0m\]"

## BEGIN Custom Aliases ##
alias ll="ls -hl --color=auto"
## END Custom Aliases ###
