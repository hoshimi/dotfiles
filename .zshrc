## set env parameters
export EDITOR=vim
export LANG=ja_JP.UTF-8
export KCODE=u

## set keybind likes vim
bindkey -v

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

## aliases
alias ls='ls -aFG'
alias ll='ls -alh'
alias pd="popd"
alias setkuinsproxy='export http_proxy="http://proxy.kuins.net:8080"'
alias kmcportforward="ssh -f -N -l a0077174 -L 16660:irc.box2.kmc.gr.jp:16660 forward.kuins.kyoto-u.ac.jp"
alias g++="g++-4.9"
alias gcc="gcc-4.9"

## history files
HISTFILE=./.zsh_history
HISTSIZE=100000
SAVEHIST=100000
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

## no regist duplicated path
typeset -U path cdpath fpath manpath

## pathes for sudo
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local/,/usr,}/sbin(N-/))

## pathes
path=(~/bin(N-/) /usr/local/bin(N-/) ${path})
fpath=(/usr/local/share/zsh-completions(N-/) ${fpath})

#    typeset 
#         -U 重複パスを登録しない
#        -x exportも同時に行う
#        -T 環境変数へ紐付け
#    
#       path=xxxx(N-/)
#         (N-/): 存在しないディレクトリは登録しない
#         パス(...): ...という条件にマッチするパスのみ残す
#            N: NULL_GLOBオプションを設定。
#               globがマッチしなかったり存在しないパスを無視する
#            -: シンボリックリンク先のパスを評価
#            /: ディレクトリのみ残す
