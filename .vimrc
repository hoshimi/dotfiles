" -- neobundle --
set nocompatible
let g:neobundle_default_git_protocol='git'
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

filetype plugin indent on

" -- neobundle installation check --
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'vim_colors'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'itchyny/lightline.vim'

filetype plugin indent on " required!
syntax on
set autoindent
set noswapfile
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/backup
set browsedir=buffer 
set clipboard=unnamed
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

" --neocomplcacheの有効化と<tab>での補完割り当て--
let g:neocomplcache_enable_at_startup = 1
function! InsertTabWrapper()
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
" --vim-bufferline--
let g:bufferline_echo = 0
let g:bufferline_active_buffer_left = '['
let g:bufferline_active_buffer_right = ']'
let g:bufferline_modified = '+'
let g:bufferline_show_bufnr = 1
let g:bufferline_rotate = 0
let g:bufferline_fname_mode = ':t'
let g:bufferline_inactive_highlight = 'StatusLineNC'
let g:bufferline_active_highlight = 'StatusLine'
let g:bufferline_solo_highlight = 0

" --vim-lightline--
set laststatus=2

let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ ['mode', 'paste'], ['readonly', 'filename', 'modified'], ['bufferline'] ] },
    \ 'component': {
    \   'readonly': '%{&filetype=="help"?"":&readonly?"Read Only":""}',
    \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
    \   'bufferline': '%{bufferline#refresh_status()}%{g:bufferline_status_info.before . g:bufferline_status_info.current . g:bufferline_status_info.after}'
    \ },
    \ 'separator': { 'left' : '', 'right' : '' },
    \ 'subseparator': { 'left' : '|', 'right' : '|' }
\ }

" --vimfiler--
let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default=0

" --quickrun--
let g:quickrun_config = {
    \ "-" : {
    \ "hook/time/enable" : 1
    \ },
    \}
" --キーマッピング--
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap ;f <F12>
nnoremap ,v :e ~/.vimrc<CR> 
nnoremap <F2> :<C-u>source ~/.vimrc<CR>
noremap <Space> :bnext<CR>
noremap <S-Space> :bprev<CR>
noremap <ESC><ESC> :nohlsearch<CR>
imap <C-Tab> <Plug>(neocomplcache_snippets_expand)
smap <C-Tab> <Plug>(neocomplcache_snippets_expand)
noremap esnip :<C-u>NeoComplCacheEditSnippets<CR>

" --unite.vim--
" Prefix
nnoremap [unite] <Nop>
nmap <Leader>f [unite]

nnoremap [unite]u :<C-u>Unite -no-split<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> [unite]a :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>

" --syntax files--
autocmd BufNewFile,BufRead *.twig set filetype=htmljinja

colorscheme wombat
