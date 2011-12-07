set nocompatible               " be iMproved
filetype off                   " required!

if has('win32') || has('win64')
    let $DOTVIM = expand('~/vimfiles')
else
    let $DOTVIM = expand('~/.vim')
endif
set rtp+=$DOTVIM/bundle/vundle/
call vundle#rc('$DOTVIM/bundle/')

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/unite.vim'
" vim-scripts repos

filetype plugin indent on " required!
syntax on
set autoindent
set backupdir=$HOME/vimbackup
set browsedir=buffer 
set clipboard=unnamed
set nocompatible
set directory=$HOME/vimbackup
set expandtab
set hidden
set incsearch
set number
set shiftwidth=4
set showmatch
set smartcase
set smartindent
set smarttab
set whichwrap=b,s,h,l,<,>,[,]
set nowrapscan
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

inoremap <silent> <ESC> <ESC>
inoremap <silent> <C-[> <ESC>

au BufNewFile,BufRead * set iminsert=0
au BufNewFile,BufRead * set tabstop=4 shiftwidth=4
au BufNewFile,BufRead *.rhtml   set nowrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.rb  set nowrap tabstop=2 shiftwidth=2

highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

" --plugin--
" --neocomplcacheの有効化と<tab>での補完割り当て--
let g:neocomplcache_enable_at_startup = 1
function InsertTabWrapper()
    if pumvisible()
        return "\<c-n>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
        return "\<tab>"
    elseif exists('&omnifunc') && &omnifunc == ''
        return "\<c-n>"
    else
        return "\<c-x>\<c-o>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" --vimfiler--
let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default=0
" --buftabs--
let g:buftabs_only_basename=1
let g:buftabs_in_statusline=1
let g:buftabs_active_highlight_group="Visual"
" --キーマッピング--
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
noremap <Space> :bnext<CR>
noremap <S-Space> :bprev<CR>
noremap <ESC><ESC> :nohlsearch<CR>
imap <C-Tab> <Plug>(neocomplcache_snippets_expand)
smap <C-Tab> <Plug>(neocomplcache_snippets_expand)
noremap esnip :<C-u>NeoComplCacheEditSnippets<CR>
" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix') && !has('gui_running')
  let uname = system('uname')
  if uname =~? "linux"
    set term=builtin_linux
  elseif uname =~? "freebsd"
    set term=builtin_cons25
  elseif uname =~? "Darwin"
    set term=beos-ansi
  else
    set term=builtin_xterm
  endif
  unlet uname
endif
