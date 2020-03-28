call plug#begin('~/.config/nvim/autoload')

" I use vim-plug to as vim plugin manager
" use command: :PlugInstall to install all plugins
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
"Plug 'zxqfl/tabnine-vim'
Plug 'voldikss/vim-floaterm'
"Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'MarcWeber/vim-addon-local-vimrc'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-surround'
Plug 'lyuts/vim-rtags'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" gtag support
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'

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

map <Leader>yy "+y
"nmap <Leader>yyy "+yy
map <Leader>pp "+p

nmap sv :vsp<CR>
nmap sh :sp<CR>
nmap <Leader>qq :q<CR>
"use esc to exit insert mode in terminal-emulator
tnoremap <Esc> <C-\><C-n>
"save and restore session
nmap <Leader>ss :mksession!<CR> :wviminfo! viminfo<CR>
nmap <Leader>rs :source Session.vim<CR> :rviminfo! viminfo<CR>

autocmd FileType python setlocal foldmethod=indent et sta sw=4 sts=4

"==========tagbar config===================================
map <F8> :TagbarToggle<CR>

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

"====================vim-clap==============================
"nmap <Leader>ff :Clap git_files<CR>
"nmap <Leader>fg :Clap grep<CR>

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

"================vim-cpp-enhanced-highlight========================
let g:cpp_class_scope_highlight = 1
let g:cpp_concepts_highlight = 1
let c_no_curly_error=1

"================ rainbow ==========================================
let g:rainbow_active = 1

"================vim-easy-align========================
" Start interactive EasyAlign in visual mode (e.g. vipga)
 xmap ga <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
 nmap ga <Plug>(EasyAlign)

"============================  Leader F  ==========================

" search word under cursor, the pattern is treated as regex, and enter normal mode directly
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" recall last search. If the result window is closed, reopen it.
noremap go :<C-U>Leaderf! rg --stayOpen --recall<CR>
"tag search
noremap <leader>t :<C-U>Leaderf tag<CR>

" C+j C+k to navigat search result
let g:Lf_CommandMap = {'<C-k>': ['<Up>'], '<C-j>': ['<Down>']}

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

"=============================gtags================================
" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.git', 'compile_commands.json']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" not generate data base for these directory
let g:gutentags_ctags_exclude = ['.ccls', '.ccls-cache', '.git']
let g:gutentags_exclude_project_root = ['.ccls', '.ccls-cache', '.git']

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" forbid gutentags adding gtags databases
"let g:gutentags_auto_add_gtags_cscope = 0

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

"=============================coc.vim================================
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" conflict with leaderf
xmap <leader>fm  <Plug>(coc-format-selected)
nmap <leader>fm  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }



" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
