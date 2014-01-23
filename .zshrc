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

## enable complection
autoload -Uz compinit
compinit
setopt autolist
setopt auto_menu
setopt list_packed
setopt list_types
bindkey "^[[Z" reverse-menu-complete
zstyle ':complection:*' matcher-list 'm:{a-z}={A-Z}'

## glob
unsetopt caseglob

## global aliases
alias -g L='| less'
alias -g G='| grep'
alias ls='ls -aFG'
alias ll='ls -alh'
alias pd="popd"
alias setkuinsproxy='export http_proxy="http://proxy.kuins.net:8080"'


## history files
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups

## set colors
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## set prompt
autoload -U colors;
colors
tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
    tmp_prompt="%B%U${tmp_prompt}%u%b"
    tmp_prompt2="%B%U${tmp_prompt2}%u%b"
    tmp_rprompt="%B%U${tmp_rprompt}%u%b"
    tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
      PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

function chpwd() {
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
[ -f ~/.zshrc_local ] && source ~/.zshrc_local
