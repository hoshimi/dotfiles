" -- neobundle --
let g:neobundle_default_git_protocol='git'
filetype off

if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/vimfiles/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/vimfiles/bundle/'))


" -- neobundle installation check --
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'ujihisa/unite-font'
NeoBundle 'vim_colors'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/vimproc', {
    \'build': {
        \   'windows': 'tools\\update-dll-mingw',
        \   'cygwin': 'make -f make_cygwin.mak',
        \   'mac': 'make -f make_mac.mak',
        \   'linux': 'make',
        \   'unix': 'gmake',
    \},
\ }
call neobundle#end()

filetype plugin indent on " required!
syntax on
set autoindent
set noswapfile
set backupdir=$HOME/vimfiles/backup
set directory=$HOME/vimfiles/backup
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
set textwidth=0

let g:tex_conceal = ''
let g:tex_flavor='latex'

augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

inoremap <silent> <ESC> <ESC>
inoremap <silent> <C-[> <ESC>
let mapleader = ","
noremap \ ,

" --neocomplcache--
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" <TAB>: completion.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

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
    \ "_" : {
        \ "hook/time/enable" : 1,
        \ "outputter/buffer/name" : "quickrun",
        \ "outputter/buffer/split" : "vertical",
    \ },
\}

let g:quickrun_config['tex'] = {
    \   'command' : 'latexmk',
    \ 'outputter/error/error' : 'quickfix',
    \   'cmdopt': '-pdfdvi',
    \   'exec': ['%c %o %s']
\}

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
        unlet g:quickrun_config['tex']['srcfile']
    endif
endfunction

function! s:TexPdfView()
    let texPdfFilename = expand('%:r').'.pdf'
    if exists("g:quickrun_config['tex']['srcfile']")
        let texPdfFilename = fnamemodify(g:quickrun_config['tex']['srcfile'], ':.:r') . '.pdf'
    endif
    if has('win32')
        let g:TexPdfViewCommand = '!start '.
                    \             '"C:/Program Files (x86)/SumatraPDF/SumatraPDF.exe" -reuse-instance '.
                    \             texPdfFilename
    endif
    if has('unix')
        let g:TexPdfViewCommand = '! '.
                    \             'open '.
                    \             texPdfFilename
    endif
    execute g:TexPdfViewCommand
endfunction

nmap sq :bd<CR>
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap ;f <F12>
nnoremap <Leader>c :e ~/_vimrc<CR> 
nnoremap <F2> :<C-u>source ~/_vimrc<CR>
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
" set shiftwidth by FileType
autocmd! FileType fortran setlocal shiftwidth=2 tabstop=2 softtabstop=2

colorscheme wombat
