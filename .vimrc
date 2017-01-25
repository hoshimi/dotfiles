let hostname = substitute(system('hostname'), '\n', '', '')

" win32 settings
if has('win32')
    set runtimepath+=$HOME/.vim/,$HOME/.vim/after
    let s:dein_repo_dir = expand('$HOME/.vim/dein.vim')
else
    let s:dein_repo_dir = expand('~/.vim/dein.vim')
endif

" dein自体の自動インストール
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" -- neobundle --
" let g:neobundle_default_git_protocol='ssh'
filetype off
if has('vim_starting')
  if &compatible | set nocompatible | endif
endif
if has('win32')
    call dein#begin(expand('$HOME/.vim/dein'))
else
    call dein#begin(expand('~/.vim/dein'))
endif

call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('tyru/caw.vim.git')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/unite-outline')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/vimfiler')
"call dein#add('Shougo/vimshell')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('tacroe/unite-mark')
call dein#add('thinca/vim-quickrun')
"call dein#add('cohama/agit.vim')
call dein#add('kmnk/vim-unite-giti')
call dein#add('kshenoy/vim-signature')
call dein#add('fuenor/im_control.vim')
call dein#add('tpope/vim-surround')
call dein#add('open-browser.vim')
call dein#add('bling/vim-bufferline')
call dein#add('lervag/vimtex')
call dein#add('Konfekt/FastFold')
call dein#add('itchyny/lightline.vim')
call dein#add('tpope/vim-fugitive')

call dein#end()
filetype plugin indent on
syntax enable
set autoindent number noswapfile
set expandtab hidden incsearch number
set showmatch smartcase smartindent smarttab nowrapscan
set shiftwidth=4
set softtabstop=4
set scrolloff=4
set textwidth=0
set whichwrap=b,s,h,l,<,>,[,]
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/backup
set undodir=$HOME/.vim/undo
set browsedir=buffer
set clipboard+=unnamed,autoselect
set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp,iso-2022-js
set fileformats=unix,dos,mac
set backspace=indent,eol,start
set mouse=""

" fortran settings
let g:fortran_indent_more=1
let g:fortran_do_enddo=1
" set shiftwidth by FileType
autocmd! FileType fortran setlocal shiftwidth=2 tabstop=2 softtabstop=2

" TeX settings
let g:tex_conceal=''
let g:tex_flavor='latex'

" neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions',
            \ 'cs' : $HOME.'/.vim/dict/unity.dict'
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
" autocmd FileType python setlocal completeopt-=preview omnifunc=jedi#completions

if(!exists('g:neocomplete#force_omni_input_patterns'))
    let g:neocomplete#force_omni_input_patterns = {}
endif
" let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

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

" D unittest for quickrun
nnoremap <buffer> <Leader>R :<C-u>QuickRun d_unittest<CR>

" open-browser
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx :OpenBrowser http://eowpf.alc.co.jp/search?q=<C-r><C-w><CR>
nmap gxf :OpenBrowser http://eowpf.alc.co.jp/search?q=<C-r>"<CR>

" personal mapping
" tab maps
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>bd<CR>
nnoremap sQ :<C-u>q<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

" nmap <C-h> <C-w>h
" nmap <C-l> <C-w>l
" nmap <C-j> <C-w>j
" nmap <C-k> <C-w>k
noremap <F5> :e!<CR>
noremap <Space> :bnext<CR>
noremap <Tab><Space> :bprev<CR>
noremap <S-Space> :bprev<CR>
noremap <ESC><ESC> :nohlsearch<CR>

" add single space
noremap <Leader><Space> i<Space><ESC>

" caw
nmap <Leader>c <Plug>(caw:hatpos:toggle)
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)

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

" backslash
noremap! ¥ \

" silent escape
inoremap <silent> <ESC> <ESC>
inoremap <silent> <C-[> <ESC>

" braces completion
inoremap {<CR> {}<Left><CR><ESC><S-o>
inoremap [<CR> []<Left><CR><ESC><S-o>
inoremap (<CR> ()<Left><CR><ESC><S-o>
" inoremap {<SPACE> {  }<LEFT><LEFT>
" inoremap [<SPACE> [  ]<LEFT><LEFT>
" inoremap (<SPACE> (  )<LEFT><LEFT>

" undo splitting when type enter
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

" navigation in command line
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

" disable EX-mode
nnoremap  Q <Nop>
nnoremap gQ <Nop>

" Increment and decrement
nnoremap + <C-a>
nnoremap - <C-x>

" indentation in visual mode
vnoremap < <gv
vnoremap > >gv|

" always search with \v prefix
nnoremap / /\v
nnoremap ? ?\v

" Tab zsh
set wildmenu wildmode=full

" Ex mode cursor move
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" unite.vim
" Prefix
let g:unite_enable_start_insert=0
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap [unite] <Nop>
nmap U [unite]
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]o :<C-u>Unite<Space>-vertical -winwidth=30 outline<CR>
nnoremap <silent> [unite]f :<C-u>Unite<Space>file<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]y :<C-u>Unite<Space>history/yank<CR>
nnoremap <silent> [unite]a :<C-u>UniteWithCurrentDir -winwidth=40 -vertical -no-quit -buffer-name=buffer<CR>

" vimshell
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = $USERNAME."% "
nnoremap <silent> vs :VimShell<CR>
nnoremap <silent> vsc :VimShellCreate<CR>
nnoremap <silent> vp :VimShellPop<CR>

" -- vim signature --
let g:SignatureMarkTextHLDynamic = 1

" -- vimtex --"
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

" auto highlighting Traling Spaces
augroup HighlightTrailingSpaces
    autocmd!
    autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
    autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

colorscheme peachpuff
