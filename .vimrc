" Map escape to jj
imap jj <Esc>

" activates filetype detection
filetype plugin on

" Syntax highlighting
syntax on

" Set FZF Default to Ripgrep (must install ripgrep)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --no-ignore-vcs'

" Options viewable by using :options
" Set options viewable by using :set all
" Or help for individual configs can be accessed :help <name>
set nocompatible
set redrawtime=10000
set background=dark
set laststatus=2
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set nobackup
set undodir=~/.vim/undordir
set undofile 
set incsearch
set relativenumber
set cursorline
set noshowmode

" Cursor Setup
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Column set to column 100
set colorcolumn=100

" Column color set to grey
highlight ColorColumn ctermbg=1

" Plugins
call plug#begin('~/.vim/plugged')

" IndentLine Plugin to show indents
Plug 'Yggdroot/indentLine'

" Git Plugin for Vim
Plug 'tpope/vim-fugitive'

" Allows to run code on separate tmux panel
Plug 'jpalardy/vim-slime'

" Allows to run code like jupyter notebook
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

" RMarkdown Help 
Plug 'vim-pandoc/vim-rmarkdown'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc'

" Python syntax
Plug 'vim-python/python-syntax'

" Add Rstudio like terminal to vim
Plug 'jalvesaq/Nvim-R'

" R syntax completion support
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

Plug 'jalvesaq/Nvim-R'
Plug 'gaalcaras/ncm-R'

" Vim 8 only
if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" Comment and uncomment lines
Plug 'preservim/nerdcommenter'

" A light and configurable statusline/tabline plugin for Vim
" Plug 'itchyny/lightline.vim'
Plug 'itchyny/lightline.vim'

" Directory tree
Plug 'scrooloose/nerdtree'

" Visualize undo history tree (in vim undo is not linear)
Plug 'mbbill/undotree'

" Syntax highlighting for languages
Plug 'sheerun/vim-polyglot'

" Fzf is a general-purpose command-line fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Python code formatter
Plug 'ambv/black'

" Gruvbox color theme
Plug 'morhetz/gruvbox'

" Vim-monokai-tasty color theme
Plug 'patstockwell/vim-monokai-tasty'

" Vim-afterglow color theme
Plug 'danilo-augusto/vim-afterglow'

" Vim-deus color theme
Plug 'ajmwagar/vim-deus'

call plug#end()


" Set mapleader to space
let mapleader = " "
" Maps
nmap <leader>hk :vsplit ~/.vim/hotkeys<cr>
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>t :NERDTree<cr>
nmap <leader><leader>p :Prettier<cr>
nmap <leader><leader>g :GoFmt<cr>
nmap <leader><leader>b :Black<cr>
nmap <leader><leader>u :UndotreeToggle<cr>
" Files (runs $FZF_DEFAULT_COMMAND if defined)
nmap <leader><leader>f :Files<cr>
nmap <leader><leader><leader>g :GoMetaLinter<cr>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader><leader>c :call nerdcommenter#Comment(0,"toggle")<CR>
vnoremap <leader><leader>c :call nerdcommenter#Comment(0,"toggle")<CR>
nnoremap <leader><Tab> :bnext<CR>
nnoremap <leader><Tab><Tab> :bprevious<CR>


" Set the prettier CLI executable path
let g:prettier#exec_cmd_path = "~/.vim/plugged/vim-prettier/node_modules/.bin/prettier"
" Max line length that prettier will wrap on: a number or 'auto'
let g:prettier#config#print_width = 100 " default is 'auto'

" Colorscheme (For gruvbox $TERM env var needs to be xterm-256color)
"autocmd vimenter * ++nested colorscheme gruvbox
colorscheme vim-monokai-tasty
"colorscheme afterglow
"colorscheme deus

""""""""""""""""""""""""Slime settings"""""""""""""""""""""""""""""""""
"  always use tmux
let g:slime_target = 'tmux'

" Fix the paste issue
let g:slime_python_ipython = 1

" Set tmux console to push slime to
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.2"}

" Set the paste default
let g:slime_paste_file = "$HOME/.slime_paste"

"------------------------------------------------------------------------------
"" ipython-cell configuration
""------------------------------------------------------------------------------
"" Keyboard mappings. <Leader> is \ (backslash) by default

"" map <Leader>s to start IPython
nnoremap <Leader>s :SlimeSend1 ipython --matplotlib<CR>

"" map <Leader>r to run script
nnoremap <Leader>r :IPythonCellRun<CR>

"" map <Leader>R to run script and time the execution
nnoremap <Leader>R :IPythonCellRunTime<CR>

"" map <Leader>c to execute the current cell
nnoremap <Leader>c :IPythonCellExecuteCell<CR>

"" map <Leader>C to execute the current cell and jump to the next cell
nnoremap <Leader>C :IPythonCellExecuteCellJump<CR>

"" map <Leader>l to clear IPython screen
nnoremap <Leader>l :IPythonCellClear<CR>

"" map <Leader>x to close all Matplotlib figure windows
nnoremap <Leader>x :IPythonCellClose<CR>

"" map [c and ]c to jump to the previous and next cell header
nnoremap [c :IPythonCellPrevCell<CR>
nnoremap ]c :IPythonCellNextCell<CR>

"" map <Leader>h to send the current line or current selection to IPython
nmap <Leader>h <Plug>SlimeLineSend
xmap <Leader>h <Plug>SlimeRegionSend

"" map <Leader>p to run the previous command
nnoremap <Leader>p :IPythonCellPrevCommand<CR>

"" map <Leader>Q to restart ipython
nnoremap <Leader>Q :IPythonCellRestart<CR>

"" map <Leader>d to start debug mode
nnoremap <Leader>d :SlimeSend1 %debug<CR>

"" map <Leader>q to exit debug mode or IPython
nnoremap <Leader>q :SlimeSend1 exit<CR>

"" map <F9> and <F10> to insert a cell header tag above/below and enter insert
"mode
nmap <F9> :IPythonCellInsertAbove<CR>a
nmap <F10> :IPythonCellInsertBelow<CR>a

"" also make <F9> and <F10> work in insert mode
imap <F9> <C-o>:IPythonCellInsertAbove<CR>
imap <F10> <C-o>:IPythonCellInsertBelow<CR>

""" Change lightline set up
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ }

"" Set for python-syntax
let g:python_highlight_all = 1

""""""" Syntax for IndentLine
" set line types for different indents
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

""""""" Set colorscheme
colorscheme molokai

"""""" Set Nvim-R settings
" Change Leader and LocalLeader keys:
let maplocalleader = ','
let mapleader = ';'
" Use Ctrl+Space to do omni completion:
if has('nvim') || has('gui_running')
   inoremap <C-Space> <C-x><C-o>
else
   inoremap <Nul> <C-x><C-o>
endif
" Press the space bar to send lines and selection to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine
