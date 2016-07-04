let hostname = substitute(system('hostname'), '\n', '', '')

if has('win32')
    set runtimepath+=$HOME/.vim/,$HOME/.vim/after
endif

" -- neobundle --
let g:neobundle_default_git_protocol='https'
filetype off

if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'ujihisa/unite-font'
NeoBundle 'vim_colors'
NeoBundle 'cohama/agit.vim'
NeoBundle 'tacroe/unite-mark'
NeoBundle 'kshenoy/vim-signature'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'fuenor/im_control.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tyru/caw.vim.git'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'lervag/vimtex'
NeoBundle 'Konfekt/FastFold'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/vimproc.vim', {
    \'build': {
        \   'windows': 'tools\\update-dll-mingw',
        \   'cygwin': 'make -f make_cygwin.mak',
        \   'mac': 'make -f make_mac.mak',
        \   'linux': 'make',
        \   'unix': 'gmake',
    \},
\}
NeoBundle 'open-browser.vim'

call neobundle#end()

filetype plugin indent on " required!
NeoBundleCheck
syntax on
set autoindent
" set shellslash
set noswapfile
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/backup
set undodir=$HOME/.vim/undo
set browsedir=buffer
set clipboard+=unnamed,autoselect
set expandtab
set hidden
set incsearch
set number
set shiftwidth=4
set softtabstop=4
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
set backspace=indent,eol,start
set mouse=""
let g:fortran_indent_more=1
let g:fortran_do_enddo=1

" TeX settings
let g:tex_conceal=''
let g:tex_flavor='latex'

augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

" neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal completeopt-=preview omnifunc=jedi#completions

" jedi.vim
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

if(!exists('g:neocomplete#force_omni_input_patterns'))
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.tex =
        \ '\v\\%('
        \ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
        \ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
        \ . '|hyperref\s*\[[^]]*'
        \ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
        \ . '|%(include%(only)?|input)\s*\{[^}]*'
        \ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
        \ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
        \ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
        \ . ')'

" neosnippet
imap <C-b> <Plug>(neosnippet_expand_or_jump)
smap <C-b> <Plug>(neosnippet_expand_or_jump)

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
    \   'left': [ ['mode', 'paste'], ['readonly', 'filename', 'modified'], ['bufferline'], ['imcontrol'] ] },
    \ 'component': {
    \   'readonly': '%{&filetype=="help"?"":&readonly?"Read Only":""}',
    \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
    \   'bufferline': '%{bufferline#refresh_status()}%{g:bufferline_status_info.before . g:bufferline_status_info.current . g:bufferline_status_info.after}',
    \   'imcontrol': '%{has("gui_running")?IMStatus("ime fixed"):""}',
    \ },
    \ 'separator': { 'left' : '', 'right' : '' },
    \ 'subseparator': { 'left' : '|', 'right' : '|' }
\ }

if has('gui_running')
  let IM_CtrlMode = 4
  inoremap <silent> <C-e> <C-^><C-r>=IMState('FixMode')<CR>
else
  set t_Co=256
  let IM_CtrlMode = 0
endif

" --vimfiler--
let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default=0

" --quickrun--
let g:quickrun_config = {
    \ "-" : {
        \ "hook/time/enable" : 1,
        \ "outputter/buffer/name" : "quickrun",
        \ "outputter/buffer/split" : "vertical",
    \ },
    \ "d_unittest" : {
        \ "command" : "rdmd",
        \ "cmdopt" : "-unittest -main -g",
    \}
\}

let mapleader = ","
let maplocalleader = ","
noremap \ ,

" D unittest
nnoremap <buffer> <Leader>R :<C-u>QuickRun d_unittest<CR>

nmap sq :bd<CR>
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap ;f <F12>
noremap <F5> :e!<CR>
noremap <Space> :bnext<CR>
noremap <Tab><Space> :bprev<CR>
noremap <ESC><ESC> :nohlsearch<CR>

" open-browser
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx :OpenBrowser http://wordnet.i.cmaas.net/<C-r><C-w><CR>
" vmap gx <Plug>(openbrowser-smart-search)

" add single space
noremap <Leader><Space> i<Space><ESC>

" caw
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" move on display lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" n iikanzi
noremap n nzz
noremap N Nzz

" equiv yy
noremap Y y$

" silent escape
inoremap <silent> <ESC> <ESC>
inoremap <silent> <C-[> <ESC>

" braces completion
inoremap {<CR> {}<Left><CR><ESC><S-o>
inoremap [<CR> []<Left><CR><ESC><S-o>
inoremap (<CR> ()<Left><CR><ESC><S-o>
inoremap {<SPACE> {  }<LEFT><LEFT>
inoremap [<SPACE> [  ]<LEFT><LEFT>
inoremap (<SPACE> (  )<LEFT><LEFT>

" undo splitting
inoremap <CR> <C-g>u<CR>

" mappings in insert mode
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-a> <ESC>A
inoremap <silent> <C-x> <BS>
inoremap <silent> <C-d> <Del>
inoremap <C-z> <ESC><Undo>

" always search with \v prefix
nnoremap / /\v
nnoremap ? ?\v

" Tab zsh
set wildmenu
set wildmode=full

" Ex mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" unite.vim
" Prefix
nnoremap [unite] <Nop>
nmap <Leader>f [unite]

nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>-vertical -winwidth=30 mark<CR>
nnoremap <silent> [unite]o :<C-u>Unite<Space>-vertical -winwidth=30 -no-quit outline<CR>
nnoremap <silent> [unite]a :<C-u>UniteWithCurrentDir -buffer-name=file buffer bookmark file<CR>

" vimshell
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = $USERNAME."% "
nnoremap <silent> vs :VimShell<CR>
nnoremap <silent> vsc :VimShellCreate<CR>
nnoremap <silent> vp :VimShellPop<CR>

" -- vim signature --
let g:SignatureMarkTextHLDynamic = 1

let g:vimtex_complete_close_braces = 1
let g:vimtex_latexmk_enabled = 1
let g:vimtex_latexmk_options = '-pdfdvi'
let g:vimtex_latexmk_continuous = 1
let g:vimtex_latexmk_background = 1
let g:vimtex_view_method = 'general'
let g:vimtex_latexmk_callback = 0
let g:vimtex_quickfix_mode = 2 " open quickfix window but not be active

if has('win32')
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk = '-reuse-instance'
elseif has('unix')
    if system('uname')=~'Darwin'
        let g:vimtex_view_general_viewer
                  \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
        let g:vimtex_view_general_options = '-r @line @pdf @tex'

	let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']

	function! UpdateSkim(status)
	    if !a:status | return | endif

	    let l:out = b:vimtex.out()
	    let l:cmd = [g:vimtex_view_general_viewer, '-r']
	    if !empty(system('pgrep Skim'))
		call extend(l:cmd, ['-g'])
	    endif
	    if has('nvim')
		call jobstart(l:cmd + [line('.'), l:out])
	    elseif has('job')
		call job_start(l:cmd + [line('.'), l:out])
	    else
		call system(join(l:cmd + [line('.'), shellescape(l:out)], ' '))
	    endif
	endfunction
    else
        let g:vimtex_view_general_viewer = 'open'
    endif
endif

" fold
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_automatic = 0
let g:vimtex_fold_envs = 1

let g:vimtex_toc_split_pos = "topleft"
let g:vimtex_toc_width = 10

augroup myLaTeXQuickrun
    if has('gui_running')
        au BufEnter *.tex inoremap <silent> $  <C-g>u$$<ESC>:call IMState("Leave")<CR>i
    endif
augroup END

function! s:TeXDollarFunc()
    " ime fixed?
    let s:cmd = "<Left>"
    if g:IMState == 2
        s:cmd += "<C-^>"
    endif

    return s:cmd

endfunction

" set shiftwidth by FileType
autocmd! FileType fortran setlocal shiftwidth=2 tabstop=2 softtabstop=2

" auto highlighting Traling Spaces
augroup HighlightTrailingSpaces
    autocmd!
    autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
    autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END
colorscheme wombat
