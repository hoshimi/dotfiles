" -- neobundle --
let g:neobundle_default_git_protocol='git'
filetype off

if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" -- neobundle installation check --
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'vim_colors'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/vimproc.vim', {'build': {'mac': 'make -f make_mac.mak'}}

call neobundle#end()

filetype plugin indent on " required!
NeoBundleCheck
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
set scrolloff=4
set showmatch
set smartcase
set smartindent
set smarttab
set textwidth=0
set whichwrap=b,s,h,l,<,>,[,]
set nowrapscan
set encoding=utf-8
set fileencodings=utf-8

" set shiftwidth by FileType
autocmd! FileType fortran setlocal shiftwidth=2 tabstop=2 softtabstop=2

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

if !has('gui_running')
    set t_Co=256
endif

" --vimfiler--
let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default=0

" --quickrun--
let g:quickrun_config = {
    \ "-" : {
    \ "hook/time/enable" : 1
    \ },
    \}

" --quickrun for latexmk--
" .tex ファイルの場合に<Leader>rでタイプセット
let g:quickrun_config['tex'] = {
            \ 'command':'latexmk',
            \ 'outputter': 'error',
            \ 'outputter/error/error' : 'quickfix',
            \ 'cmdopt' : '-pdfdvi',
            \ 'exec' : ['%c %o %s']
            \ }

" --キーマッピング--
let mapleader = ","
noremap \ ,

nmap sq :bd<CR>
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

augroup myLaTeXQuickrun
    au!
    au BufEnter *.tex call <SID>SetLaTeXMainSource()
    au BufEnter *.tex nnoremap <Leader>v :call <SID>TexPdfView() <CR>
augroup END

function! s:SetLaTeXMainSource()
    let currentFileDirectory = expand('%:p:h').'\'
    let latexmain = glob(currentFileDirectory.'*.latexmain')
    let g:quickrun_config['tex']['srcfile'] = fnamemodify(latexmain, ':r')
    if latexmain == ''
        let g:quickrun_config['tex']['srcfile'] = expand("%")
    endif
endfunction

function! s:TexPdfView()
    if exists("g:quickrun_config['tex']['srcfile']")
        let texPdfFilename = fnamemodify(g:quickrun_config['tex']['srcfile'], ':.:r') . '.pdf'
    endif
    if has('win32')
        let g:TexPdfViewCommand = '!start '.
                    \             '"C:/Program Files (x86)/SumatraPDF/SumatraPDF.exe" -reuse-instance '.
                    \             texPdfFilename
    elseif has('unix')
        let g:TexPdfViewCommand = '! '.
                    \             'open '.
                    \             texPdfFilename
    endif
    execute g:TexPdfViewCommand
endfunction

"function! _TypesetTeX()
"    if expand("%:e") == "tex"
"        exe ":!platex ".expand("%")." && dvipdfmx ".expand("%:r").".dvi && open ".expand("%:r").".pdf"
"    else
"        echo "This file is not tex file."
"    endif
"endfunction
"
"command! TypesetTeX call _TypesetTeX()
"noremap <C-t> :TypesetTeX<CR>

colorscheme wombat
