# Global PATHs
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# terminal 
export PS1="[\u@\h \W]\\$ "

# aliases
alias ls="ls -aF"
alias ll="ls -lh"
alias ..="cd .."
alias ...="cd ..."
alias grep="grep -n --color=auto"

# load local settings 
if [ -f ~/.bashrc_local]; then
    source ~/.bashrc_local
fi
