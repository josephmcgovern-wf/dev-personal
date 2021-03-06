set number
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set softtabstop=4
set ignorecase
set tags=./tags;

inoremap jk <ESC>
let mapleader="\<Space>"
set encoding=utf-8
set expandtab
set wrap
set linebreak
" note trailing space at end of next line
" set showbreak=>\ \ \
autocmd BufWritePre * %s/\s\+$//e
nnoremap tn :TestNearest<CR>
nnoremap tt  :NERDTreeToggle<CR>
nnoremap <leader>. :CtrlPTag<cr>
map fz :Files<CR>
set clipboard=unnamed
set colorcolumn=79

set nocp
if exists('$DOTFILES')
    source $DOTFILES/vim/autoload/pathogen.vim
    source $DOTFILES/vim/vimrc
endif
filetype off

let g:ale_linters = {'python': ['pyls'], 'javascript': ['jshint']}
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 200
let g:ale_lint_delay = 200
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_lint_on_text_changed = 0
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_open_list = 1
let g:ale_list_window_size = 3
let g:ale_virtual_env_dir_names = [$VIRTUAL_ENV]
" Have clicking tab and shift-tab cycle through autocomplete suggestions
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"


execute pathogen#infect()
execute pathogen#helptags()
filetype plugin indent on

autocmd StdinReadPre * let s:std_in=1
autocmd BufReadPre *.js set shiftwidth=2 | set softtabstop=2 | set tabstop=2
autocmd BufReadPre *.jsx set shiftwidth=2 | set softtabstop=2 | set tabstop=2
autocmd BufReadPre *.yaml set shiftwidth=2 | set softtabstop=2 | set tabstop=2
autocmd BufReadPre *.html set shiftwidth=2 | set softtabstop=2 | set tabstop=2
autocmd WinEnter *zsh resize 12

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_python_checkers=['flake8']
" let g:syntastic_loc_list_height=3

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_by_filename = 0
let g:ctrlp_extensions = ['line']
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/cover/*,*/node_modules/*,*.pyc,*/venv/*,*/lib/*,*src/static/*

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap jk <C-\><C-n>
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
else
    set term=screen-256color
endif

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
cnoreabbrev Ag Ag!
cnoreabbrev Gbrowse Gbrowse @upstream
cnoreabbrev Greadm Gread master:%
nnoremap <Leader>a :Ag!<Space>

map <F5>    :ImportName<CR>
map <C-F5>  :ImportNameHere<CR>

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key
" binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1
function! s:config_easyfuzzymotion(...) abort
      return extend(copy({
        \   'converters': [incsearch#config#fuzzyword#converter()],
        \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
        \   'keymap': {"\<CR>": '<Over>(easymotion)'},
        \   'is_expr': 0,
        \   'is_stay': 1
        \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Leader>/ incsearch#go(<SID>config_easyfuzzymotion())

set mouse=a

let g:NERDSpaceDelims = 1

" Dont show scratch preview for autocomplete
" set completeopt-=preview
set completeopt=menu,menuone,preview,noselect,noinsert

let g:easytags_dynamic_files = 1
let g:easytages_syntax_keyword = 'always'
let g:easytags_async = 1
let g:easytags_auto_highlight=0
let g:ycm_collect_identifiers_from_tags_files=0

let g:autoflake_remove_all_unused_imports=1
let g:autoflake_disable_show_diff=1

set laststatus=2
set noshowmode
syntax on
colorscheme monokai
let g:lightline = {
  \     'active': {
  \         'left': [['mode', 'paste' ], ['gitbranch', 'readonly', 'relativepath', 'modified']],
  \         'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]]
  \     },
  \     'component_function': {
  \         'gitbranch': 'fugitive#head',
  \     },
  \ }
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
" let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }
let g:fzf_nvim_statusline = 0 " disable statusline overwriting

let test#strategy = "dispatch"
let test#python#runner = 'nose'

" Automatically close quickfix/loclist when main buffer is closed
autocmd WinEnter * if &buftype ==# 'quickfix' && winnr('$') == 1 | quit | endif
