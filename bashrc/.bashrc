#
# ~/.bashrc
#
#
# Regular Colors
RED="\[\033[31m\]"
GREEN="\[\033[32m\]"
YELLOW="\[\033[33m\]"
BLUE="\[\033[34m\]"
MAGENTA="\[\033[35m\]"
CYAN="\[\033[36m\]"
WHITE="\[\033[37m\]"
RESET="\[\033[0m\]"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# for completion of tools like "git bra <tab>" -> "git branch"
[[ -r /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion


alias ls='ls --color=auto'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '
# PS1='\W \$ '
PS1='${debian_chroot:+($debian_chroot)}\[\033[36m\]\W \[\033[01;37m\]\$ \[\033[00m\]'

alias ll='ls -la --color=auto'
alias vim='nvim'

export SUDO_EDITOR="nvim"
