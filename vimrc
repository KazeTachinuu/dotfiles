source $VIMRUNTIME/defaults.vim        " first: any user vimrc disables defaults.vim

augroup dotfiles | autocmd! | augroup END  " one autocmd group, cleared on re-source

" ---- interface -------------------------------------------------------------
set number                             " line numbers (gcc and gdb speak in them)
set mouse=a                            " mouse in every mode, any terminal
set wildmode=longest:full,full         " complete longest, then cycle
set wildoptions=pum                    " popup completion menu for :commands
set laststatus=2                       " always show the statusline
set scrolloff=8                        " keep context around the cursor
set cursorline                         " highlight the current line
set breakindent                        " wrapped lines keep their indent
set splitright splitbelow              " new splits open right/below
set hidden                             " switch buffers without saving first
set autoread                           " pick up external file changes
set ttimeoutlen=50                     " snappy Esc
set clipboard=unnamedplus              " y/p use the system clipboard

" ---- colors ----------------------------------------------------------------
set termguicolors background=dark
silent! colorscheme habamax

" ---- C style (EPITA) -------------------------------------------------------
set colorcolumn=80                     " the style's hard line limit
set expandtab tabstop=4 shiftwidth=4 softtabstop=4
set shiftround                         " >> snaps to multiples of 4
set autoindent
set list listchars=tab:>-,trail:-      " expose tabs and trailing spaces
autocmd dotfiles FileType c,cpp setlocal cinoptions=(0,:0 formatoptions+=j

" ---- search ----------------------------------------------------------------
set hlsearch ignorecase smartcase      " highlight all; smart casing
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" ---- files: undo yes, clutter no -------------------------------------------
set undofile undodir=~/.vim/undo//     " undo history survives closing files
silent! call mkdir($HOME . '/.vim/undo', 'p')
set nowritebackup noswapfile           " no *~ and .swp litter in repos

" ---- movement --------------------------------------------------------------
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap <Down> gj
nnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
" half-page jumps and search hits keep the cursor centered
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv
" join lines without moving the cursor
nnoremap J mzJ`z

" ---- leader ----------------------------------------------------------------
nnoremap <Space> <Nop>
let mapleader = " "

" ---- files and buffers -----------------------------------------------------
let g:netrw_banner = 0                 " netrw: no banner,
let g:netrw_liststyle = 3              "        tree view
nnoremap <C-n> :Lexplore<CR>
set path+=**                           " :find any file in the repo

" ---- C workflow: build, jump, format ---------------------------------------
set autowrite                          " save before :make
nnoremap <leader>m :make<CR>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprev<CR>
nnoremap <leader>q :copen<CR>
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
if executable('clang-format')          " gq formats with the repo style
  autocmd dotfiles FileType c,cpp setlocal formatprg=clang-format\ --style=file\ --fallback-style=none
endif

" ---- built-in power ---------------------------------------------------------
packadd! termdebug                     " :Termdebug ./a.out - GDB UI in vim
packadd! comment                       " gcc / gc toggles comments
packadd! matchit                       " % jumps on #if / #endif
runtime ftplugin/man.vim               " :Man malloc (K also works bare)
