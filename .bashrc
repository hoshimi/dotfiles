# Global PATHs
export PATH=/usr/local/go/bin:/usr/local/bin:/usr/local/sbin:$PATH

# terminal
export PS1="[\u@\h \W]\\$ "

# source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# aliases
alias ..="cd .."
alias ...="cd ..."
alias ls='ls -GaF'
alias ll='ls -lh'
alias :q='exit'
alias diff='diff -y --suppress-common-lines'
alias grep='grep -n --color=auto'
alias gst='git status'
alias less="less -R"
alias lv="lv -c"

# load local settings
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi
