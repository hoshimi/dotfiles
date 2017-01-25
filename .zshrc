# zplug
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    curl -skL zplug.sh/installer | zsh
fi

source ~/.zplug/init.zsh

zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'zsh-users/zsh-history-substring-search'
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug 'b4b4r07/enhancd', use:init.sh
zplug "mollifier/anyframe"

# pretzo themes
zplug "sorin-ionescu/prezto", as:plugin, use:init.zsh, hook-build:"ln -s $ZPLUG_ROOT/repos/sorin-ionescu/prezto ${ZDOTDIR:-$HOME}/.zprezto"
zstyle ':prezto:load' pmodule 'tmux' 'prompt'
zstyle ':prezto:module:prompt' theme 'powerline'

if [[ $OSTYPE == *darwin* ]]; then
    zplug 'modules/osx', from:prezto
    zstyle ':prezto:module:tmux:iterm' integrate 'yes'
fi

if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi

zplug load --verbose

## set env parameters
export EDITOR=vim
export LANG=ja_JP.UTF-8
export KCODE=u

## set keybind likes vim
bindkey -v
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history
bindkey '^R' history-incremental-search-backward

## set options
setopt print_eight_bit
setopt no_beep
setopt auto_cd
setopt auto_pushd
setopt correct
setopt magic_equal_subst
setopt equals
#
# ## enable complection
autoload -Uz compinit
compinit
setopt autolist
setopt auto_menu
setopt list_packed
setopt list_types
bindkey "^[[Z" reverse-menu-complete

## glob
unsetopt caseglob

## global aliases
alias -g L='| less'
alias -g G='| grep'
if [ "$(uname)" = 'Darwin' ]; then
    alias ls='ls -aFG'
    alias ll='ls -alhG'
else
    alias ls='ls -aF --color=always'
    alias ll='ls -alh --color=always'
fi
alias pd="popd"
alias ps2pdf='ps2pdf -dEPSCrop -dAutoFilterColorImages=false -dColorImageFilter=/FlateEncode'
alias gst='git status'
alias ..="cd .."
alias :q="exit"
alias gpp="g++ -o"
alias less="less -R"
alias lv="lv -c"
alias diff="diff -y --suppress-common-lines"
alias grep="grep -n --color=auto"
alias mv="mv -v"
alias gst="git status"

## history files
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# auto ls
chpwd() {
    ls_abbrev
}
ls_abbrev() {
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}

# Load local settings
function load_rc { [ -f ~/.zshrc_$1 ] && source ~/.zshrc_$1 }

load_rc local
