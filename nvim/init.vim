let mapleader=" "

" Enable and disable auto comment
map <leader>c :setlocal formatoptions-=cro<CR>
map <leader>C :setlocal formatoptions=cro<CR>

" Enable spell checking, s for spell check
map <leader>s :setlocal spell! spelllang=en_us<CR>


" Shortcutting split navigation
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Shortcut split opening
nnoremap <leader>hs :split<Space>
nnoremap <leader>vs :vsplit<Space>

" Undo
map <C-u> :undo<CR>
" Save File Shortcut
map <C-s> :w<CR>

" Close nvim Shortcut
map <C-q> :wq<CR> 

"Goyo Toggle
map <C-o> :Goyo<CR>

" == VIM PLUG ================================
call plug#begin('~/.vim/plugged')
"------------------------ COC ------------------------
" coc for tslinting, auto complete and prettier
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" coc extensions
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']
"------------------------ TSX SYNTAX HIGHTLIGHTING------
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'for':['typescript', 'tsx'], 'do': './install.sh'}
"------------------------ THEME ------------------------
" most importantly you need a good color scheme to write good code :D
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/goyo.vim'
" Nerd Tree for toggleable file tree" 
Plug 'preservim/nerdtree'
" syntax hightlighting
Plug 'sheerun/vim-polyglot'
" Linting
Plug 'dense-analysis/ale'
" working with tags
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
" Vim Airline 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Neovim Terminal
Plug 'kassio/neoterm'
Plug 'junegunn/fzf.vim'

call plug#end()
" == VIMPLUG END ================================

" Basic settings
set mouse=a
syntax on
set ignorecase
set smartcase
set encoding=utf-8
set number relativenumber
set clipboard+=unnamedplus
set noruler
set tabstop=4
set autoread
set spell
set shiftwidth=4
set showmatch
set noerrorbells



set t_Co=256

" Powerline fonts
let g:airline_powerline_fonts = 1

" Autocompletion
set wildmode=longest,list,full 

" Fix splitting
set splitbelow splitright

" ------COC SETTINGS------
 " prettier command for coc
  command! -nargs=0 Prettier :CocCommand prettier.formatFile
  let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-tsserver',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-prettier',
    \ 'coc-json',
    \ 'coc-omnisharp'
    \ ]

" From Coc Readme
  set updatetime=50
" Font Override
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"NERDTree
" How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" toggle NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__', 'node_modules']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

func GoYCM()
    :CocDisable
    nnoremap <buffer> <silent> <leader>gd :YcmCompleter GoTo<CR>
    nnoremap <buffer> <silent> <leader>gr :YcmCompleter GoToReferences<CR>
    nnoremap <buffer> <silent> <leader>rr :YcmCompleter RefactorRename<space>
endfun

fun! GoCoc()
    inoremap <buffer> <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()

    inoremap <buffer> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    inoremap <buffer> <silent><expr> <C-space> coc#refresh()

    " GoTo code navigation.
    nmap <buffer> <leader>gd <Plug>(coc-definition)
    nmap <buffer> <leader>gy <Plug>(coc-type-definition)
    nmap <buffer> <leader>gi <Plug>(coc-implementation)
    nmap <buffer> <leader>gr <Plug>(coc-references)
    nnoremap <buffer> <leader>cr :CocRestart
endfun

autocmd BufWritePre * :call TrimWhitespace()
autocmd FileType typescript,tsx :call GoYCM()
