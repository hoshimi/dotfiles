# enable complection
autoload -Uz compinit
compinit

# global aliases
alias ls='ls -aFG'
alias ll='ls -alh'
alias -g L='| less'
alias -g G='| grep'

## history files
HISTFILE=./.zsh_history
HISTSIZE=100000
SAVEHIST=100000

export LANG=ja_JP.UTF-8
setopt print_eight_bit

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
#            .: 通常のファイルのみ残す
