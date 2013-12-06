# .bashrc
# PATHs
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# terminal 
export PS1="[\u@\h \W]\\$ "

# aliases

alias ls="ls -aF"
alias ll="ls -lh"
alias ..="cd .."
alias ...="cd ..."
alias grep="grep -n --color=auto"

# load brew bash completion
if type brew >/dev/null 2>&1; then
    BREW_PREFIX=$(brew --prefix)
    if [ -e $BREW_PREFIX/Library/Contributions/brew_bash_completion.sh ]; then
        source $BREW_PREFIX/Library/Contributions/brew_bash_completion.sh >/dev/null 2>&1
    fi
fi
