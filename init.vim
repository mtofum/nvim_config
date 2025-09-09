call plug#begin('~/.config/nvim/autoload')

" I use vim-plug to as vim plugin manager
" use command: :PlugInstall to install all plugins
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
"Plug 'github/copilot.vim'
Plug 'voldikss/vim-floaterm'
"Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"Plug 'MarcWeber/vim-addon-local-vimrc'
Plug 'vim-airline/vim-airline'
"Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/DoxygenToolkit.vim'
"Plug 'octol/vim-cpp-enhanced-highlight'

"Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'luochen1990/rainbow'
Plug 'tpope/vim-surround'
"Plug 'lyuts/vim-rtags'
"Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-syntastic/syntastic'
" gtag support
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'skywind3000/gutentags_plus'
" rust support
Plug 'rust-lang/rust.vim'
"Plug 'vim-scripts/fcitx.vim'

" Initialize plugin system
call plug#end()

lua require("plugin_configs.lsp")
lua require("plugin_configs.treesitter")

"tofu added
syntax on
set foldlevel=99
set foldmethod=syntax
set number
set autoindent
set cindent
set ai!
set tabstop=4
set expandtab
set shiftwidth=4
set incsearch
set mouse=a
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gbk,big5,latin1
"set nowrap
"remap leader key
let mapleader=" "
colorscheme monokai
set ignorecase

map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

map <Leader>yy "+y
"nmap <Leader>yyy "+yy
map <Leader>pp "+p

nmap sv :vsp<CR>
nmap sh :sp<CR>
nmap st :tabe %<CR>
nmap <Leader>qq :q<CR>
"use esc to exit insert mode in terminal-emulator
tnoremap <Esc> <C-\><C-n>
"save and restore session
nmap <Leader>ss :mksession!<CR> :wviminfo! viminfo<CR>
nmap <Leader>rs :source Session.vim<CR> :rviminfo! viminfo<CR>

autocmd FileType python setlocal foldmethod=indent et sta sw=4 sts=4

"==========nerdtree config===================================
map <C-e> :NERDTreeToggle<CR>
"when vim is opened without a file, open nerdtree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"close nerdtree when only nerdtree window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"=========================floaterm=========================
let g:floaterm_keymap_new = '<Leader>fn'
let g:floaterm_keymap_toggle = '<Leader>ft'
let g:floaterm_type = 'floating'
let g:floaterm_position = 'center'

"=========================symbols outline====================
map <F8> :SymbolsOutline<CR>

"=========================snippet==========================
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"add my local snippets
let g:UltiSnipsSnippetDirectories=["UltiSnips", "~/.config/nvim/snippets"]
"
"=========================vim-airline======================
let g:airline#extensions#tabline#enabled = 1
set laststatus=2  "a bug in airline, without this, airline only work when split
set t_Co=256  "enable color, with out this, airline not show in multiple color
"=====================DoxygenToolkit=======================
let g:DoxygenToolkit_authorName="Tofu Mo" 
let g:doxygenToolkit_briefTag_funcName="yes"
"=====================clang-format================================
map <C-=> :pyf ~/.vim/clang-format.py<cr>
imap <C-=> <c-o>:pyf ~/.vim/clang-format.py<cr>
"=====================neo_commenter================================
"map <C-/> <plug>NERDCommenterToggle

"================ rainbow ==========================================
let g:rainbow_active = 1

"================vim-easy-align========================
" Start interactive EasyAlign in visual mode (e.g. vipga)
 xmap ga <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
 nmap ga <Plug>(EasyAlign)

"============================  telescope  ==========================

nnoremap <Leader>fw :lua require'telescope.builtin'.grep_string{}<cr>

nmap <leader>ff <cmd>Telescope find_files<cr>
nmap <leader>fg <cmd>Telescope live_grep<cr>
nmap <leader>fb <cmd>Telescope buffers<cr>
nmap <leader>fh <cmd>Telescope help_tags<cr>

vmap <Leader>ff "zy:Telescope find_files default_text=<C-r>z<cr>
vmap <Leader>fg "zy:Telescope live_grep default_text=<C-r>z<cr>

"============================multiple-cursors======================
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>' "conflict with nerdtree
let g:multi_cursor_select_all_word_key = '<A-n>' "conflict with nerdtree
let g:multi_cursor_start_key           = 'g<C-n>' "default key map
let g:multi_cursor_select_all_key      = 'g<A-n>' "default key map
let g:multi_cursor_next_key            = '<C-n>'  "default key map
let g:multi_cursor_prev_key            = '<C-p>'  "default key map
let g:multi_cursor_skip_key            = '<C-x>'  "default key map
let g:multi_cursor_quit_key            = '<Esc>'  "default key map

