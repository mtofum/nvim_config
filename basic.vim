call plug#begin('~/.config/nvim/autoload')

" I use vim-plug to as vim plugin manager
" use command: :PlugInstall to install all plugins
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'skywind3000/asyncrun.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'easymotion/vim-easymotion'

" Initialize plugin system
call plug#end()

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
"set nowrap
"remap leader key
let mapleader=" "
colorscheme monokai

map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

nmap <Leader>y "+y
nmap <Leader>yy "+yy
nmap <Leader>p "+p
nmap <Leader>pp "0p
nmap sv :vsp<CR>
nmap sg :sp<CR>
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

"=========================vim-airline======================
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
set laststatus=2  "a bug in airline, without this, airline only work when split
set t_Co=256  "enable color, with out this, airline not show in multiple color

"============================  Leader F  ==========================

" search word under cursor, the pattern is treated as regex, and enter normal mode directly
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" recall last search. If the result window is closed, reopen it.
noremap go :<C-U>Leaderf! rg --stayOpen --recall<CR>
"tag search
noremap <leader>t :<C-U>Leaderf tag<CR>

" C+j C+k to navigat search result
let g:Lf_CommandMap = {'<C-k>': ['<Up>'], '<C-j>': ['<Down>']}

