## zplug
# Check zplug installation
if [[ ! -d ~/.zplug ]]; then
    curl -sL https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

source ~/.zplug/init.zsh

zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'zsh-users/zsh-history-substring-search'
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug 'b4b4r07/enhancd', use:init.sh

# pretzo themes
zplug "sorin-ionescu/prezto", as:plugin, use:init.zsh, hook-build:"ln -s $ZPLUG_ROOT/repos/sorin-ionescu/prezto ${ZDOTDIR:-$HOME}/.zprezto"
zstyle ':prezto:load' pmodule 'tmux' 'prompt'
zstyle ':prezto:module:prompt' theme 'steeef'

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
export ENHANCD_FILTER=fzy:fzf:peco
export EDITOR=vim
export LANG=ja_JP.UTF-8
export KCODE=u

## set keybind likes vim
bindkey -v
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history
bindkey '^R' history-incremental-search-backward
bindkey '^L' autosuggest-accept
bindkey '^H' vi-kill-line

## set options
setopt print_eight_bit
setopt no_beep
setopt auto_cd
setopt auto_pushd
setopt correct
setopt magic_equal_subst
setopt equals

## enable complection
autoload -Uz compinit
compinit
setopt autolist
setopt auto_menu
setopt list_packed
setopt list_types
bindkey "^[[Z" reverse-menu-complete

## glob
unsetopt caseglob

## history files
HISTFILE=${HOME}/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## Load local setting function
function load_rc { [ -f ~/.zshrc_$1 ] && source ~/.zshrc_$1 }

load_rc mycommands
load_rc local
