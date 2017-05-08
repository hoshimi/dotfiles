set fish_theme default
set -U EDITOR vim

alias ls 'ls -aF'
alias ll 'ls -alh'

switch (uname)
    case Darwin
        alias ls 'ls -aFG'
        alias ll 'ls -alhG'
    case '*'
        alias ls 'ls -aF --color=always'
        alias ll 'ls -alh --color=always'
end

alias gst 'git status'
alias .. "cd .."
alias :q "exit"
alias less "less -R"
alias diff "diff -y --suppress-common-lines"
alias grep "grep -n --color=auto"
alias mv "mv -v"

function fish_user_key_bindings
    bind \cr peco_select_history
end
