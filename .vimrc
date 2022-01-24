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
set pythondll=libpython3.8.so

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

" Make your Vim/Neovim as smart as VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Formatter
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production',
      \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'],
      \ 'branch': 'release/0.x'
      \ }

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

""""""""""""""""""""""""coc nvim settings start""""""""""""""""""""""""

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""""""""""coc nvim settings end""""""""""""""""""""""""

" Set the prettier CLI executable path
" let g:prettier#exec_cmd_path = ~/.vim/plugged/vim-prettier/node_modules/prettier
" Max line length that prettier will wrap on: a number or 'auto'
let g:prettier#config#print_width = 100 " default is 'auto'

" Colorscheme (For gruvbox $TERM env var needs to be xterm-256color)
"autocmd vimenter * ++nested colorscheme gruvbox
"colorscheme vim-monokai-tasty
"colorscheme afterglow
"colorscheme deus

""""""""""""""""""""""""Slime settings"""""""""""""""""""""""""""""""""
"  always use tmux
let g:slime_target = 'tmux'

" Fix the paste issue
let g:slime_python_ipython = 1

" Set tmux console to push slime to
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}

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

