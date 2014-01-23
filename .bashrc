# Global PATHs
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# terminal 
export PS1="[\u@\h \W]\\$ "

# aliases
alias ..="cd .."
alias ...="cd ..."
alias ls='ls -aF --color=always'
alias ll='ls -l'
alias :q='exit'
alias diff='diff -y --suppress-common-lines'
alias grep='grep -n --color=auto'

# load local settings 
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi
