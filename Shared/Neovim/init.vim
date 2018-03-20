" install the plugin manager if it's not already installed
if has("win32")
    if empty(glob('~/AppData/Local/nvim/site/autoload/plug.vim'))
        silent !curl -fLo ~/AppData/Local/nvim/site/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif



" plugins
if has("win32")
    call plug#begin('~/AppData/Local/nvim/plugged')
else
    call plug#begin('~/.local/share/nvim/plugged')
endif

" theme
Plug 'https://github.com/morhetz/gruvbox.git'

" rust support
Plug 'https://github.com/rust-lang/rust.vim.git'

" js support
"" https://oli.me.uk/2013/06/29/equipping-vim-for-javascript/
Plug 'https://github.com/pangloss/vim-javascript.git'
Plug 'https://github.com/othree/javascript-libraries-syntax.vim.git'
"" .vue support
Plug 'https://github.com/posva/vim-vue'
"" json
"Plug 'https://github.com/elzr/vim-json.git'

" completions
Plug 'https://github.com/roxma/nvim-completion-manager.git'
"" complete words from other buffers
Plug 'https://github.com/fgrsnau/ncm-otherbuf.git'
"" basic generic syntax completions for all vim-supported languages
Plug 'https://github.com/Shougo/neco-syntax.git'
"" rust
Plug 'https://github.com/racer-rust/vim-racer.git'
Plug 'https://github.com/roxma/nvim-cm-racer.git'
"" css
Plug 'https://github.com/calebeby/ncm-css.git'
"" js
Plug 'https://github.com/roxma/nvim-cm-tern.git',
    \ {'do': 'npm install'}

" fuzzy finder
if has("win32")
    Plug 'https://github.com/junegunn/fzf.git',
        \ { 'dir': '~/local/opt/fzf', 'do': './install --bin' }
else
    Plug 'https://github.com/junegunn/fzf.git',
        \ { 'dir': '~/.local/opt/fzf', 'do': './install --bin' }
endif

Plug 'https://github.com/junegunn/fzf.vim.git'

"" for fzf's :Commits command
Plug 'https://github.com/tpope/vim-fugitive.git'

" session management
Plug 'https://github.com/tpope/vim-obsession.git'

" copy history
"Plug 'https://github.com/bfredl/nvim-miniyank.git'

" debugger
Plug 'https://github.com/dbgx/lldb.nvim.git'

" status line
Plug 'https://github.com/vim-airline/vim-airline.git'

" search and replace across files
Plug 'https://github.com/brooth/far.vim.git'

" close buffers, leaving the window intact
Plug 'https://github.com/qpkorr/vim-bufkill'

" more automated swap-file handling
"Plug 'https://github.com/gioele/vim-autoswap'

" indentation guides
"Plug 'https://github.com/nathanaelkane/vim-indent-guides.git'

" rename tabs
Plug 'https://github.com/gcmt/taboo.vim.git'

" maximise a window
Plug 'https://github.com/troydm/zoomwintab.vim.git'

" change the current directory to the project's
"Plug 'https://github.com/airblade/vim-rooter.git'

" use ale or neomake for
"" ale checks the buffer's content, neomake checks the saved file

" surround stuff
"Plug 'https://github.com/tpope/vim-surround.git'

" current word highlighter, with support for different highlights at once
"Plug 'https://github.com/lfv89/vim-interestingwords.git'

call plug#end()


" encoding for display
set encoding=utf-8
" encoding for file writing
set fileencoding=utf-8


" use unix line-endings
set fileformat=unix


" syntax highlighting
syntax on


" per-type stuff
"" filetype detection for filetype-specific plugins and indentation
filetype indent plugin on


" mouse support
set mouse=a


" disable some quirks from vi
set nocompatible


" line numbers
set number

"" disable for terminal windows
autocmd TermOpen * setlocal nonumber


" make sure the cursor always has X number of lines around it when scrolling
set scrolloff=2

"" horizontal
set sidescrolloff=5


" wrap lines without real breaks
set wrap

"" don't break up words when wrapping
set linebreak


" have the backspace key delete indents
set backspace=indent,eol,start


" automatically reload the file if it's changed with no changes internally
set autoread


" timing allowed between keypresses of key combinations
set ttimeout
set ttimeoutlen=100


" show how much has been selected in visual mode
set showcmd


" override a search's ignorecase option if the search contains uppercase
set noignorecase
set smartcase


" enable global clipboard
set clipboard=unnamedplus

"" copy on selection
"set clipboard=autoselectplus


set autoindent


" highlight current line
set cursorline


"set switchbuf=usetab


set noerrorbells
set visualbell


" disable those vim lines some files have; they can be a security risk
set nomodeline


set foldmethod=indent
set foldnestmax=3
set nofoldenable


set noswapfile


" indents
"" tab's (\t) visual width
set tabstop=4

"" use spaces for indents
set expandtab

"" how many columns do the indentation operations adjust by (<< and >>)
""" if == 0: use tabstop
set shiftwidth=0

"" how many columns a tab is in insert mode
"" if != tabstop and not expandtabs: uses a combination of tabs and spaces
""" if == -1: use shiftwidth
""" if == 0: disable
set softtabstop=0

"" when tab is used in the 'front' of a line, use shiftwidth
set nosmarttab

"" stop certain filetypes from overriding these settings
"autocmd FileType * set expandtab
"autocmd FileType * set tabstop=4


" ensure there is a newline at the end of the file
set endofline
set fixendofline


" highlighting searches
set hlsearch


" tabpages and globals are fo persist tab names
"" taboo needs tabpages and globals
set sessionoptions+=tabpages,globals


" keep splits equal on resize
autocmd VimResized * wincmd =

" splits equalise when one is added or removed
set equalalways


" long-line marker, changing the background colour
let &colorcolumn=join(range(80,999),",")
"" set colorcolumn=80


" have the arrow keys change lines
set whichwrap+=<,>,h,l,[,]


" dash as a word separator
set iskeyword+=-


" fixes slow scrolling
set lazyredraw


"" treat .vue files like standard js files
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css


" automatically enter insertmode for terminals
"autocmd BufWinEnter,WinEnter term://* startinsert
"autocmd BufLeave term://* stopinsert


" theme
colorscheme gruvbox
set background=light

"" fixes the colours
set termguicolors

let g:gruvbox_number_column='bg1'
let g:gruvbox_invert_selection=0
let g:gruvbox_invert_tabline=0
let g:gruvbox_improved_strings=1
let g:gruvbox_improved_warnings=1


" fzf
let $FZF_DEFAULT_COMMAND = "find ."


" far
let g:far#limit = 100000
let g:far#window_layout = 'bottom'
let g:far#preview_window_layout = 'right'
set wildignore=/**/node_modules/**
"" use ag to ignore .gitignore; support is coming in the beta


" nvim-completion-manager
let g:cm_complete_popup_delay = 60
let g:cm_refresh_default_min_word_len = 1
let g:cm_matcher = {'module': 'cm_matchers.prefix_matcher', 'case': 'case'}


" airline
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1
"" don't show the default mode indicator
set noshowmode
""" needed to hide unnecessary information shown by noshowmode
set shortmess+=c


" rooter; current directory updater
"let g:rooter_change_directory_for_non_project_files = 'home'
"let g:rooter_silent_chdir = 1


"" which js libraries to highlight the syntax of
""" see: https://github.com/othree/javascript-libraries-syntax.vim
"""" also supports 'vue' if vim-vue doesn't do it
let g:used_javascript_libs = 'underscore,jquery'


" fish can cause problems
if &shell =~# 'fish$'
    set shell=/bin/bash
endif


" extended % matching for HTML, etc
"" requires`filetype plugin on`
runtime macros/matchit.vim


" smart home
"" from: http://vim.wikia.com/wiki/Smart_home
""" doesn't work if there's only an indent
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>


" expand %% to current path in command mode
"" from: https://github.com/sheerun/vimrc
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


" easy search and replace
fun! Substitute()
    let search = input('Search for: ')
    if search != ''
        let replace = input('Replace with: ')
        execute ':%s/' . search . '/' . replace . '/gc'
    endif
endfun

command! Substitute call Substitute()


" strip trailing whitespace from lines on save
"" from: http://vimcasts.org/episodes/tidying-whitespace/
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


" key bindings
"" general
nnoremap <silent> <A-n> :vs <CR>
nnoremap <silent> <C-n> :tabnew <CR>
noremap <silent> <C-s> :update <CR>
inoremap <silent> <C-s> <C-o>:update <CR>
noremap <silent> <C-q> :qall <CR>
noremap <A-w> <C-w>
nnoremap <silent> <nowait> <C-w> :bd <CR>
noremap <silent> <C-z> u
inoremap <silent> <C-z> <C-o>u
noremap <silent> <C-h> :Substitute <CR>
noremap <silent> <A-h> :Farp <CR>

"" fzf
noremap <silent> <C-o> :Files <CR>
noremap <silent> <C-b> :Buffers <CR>
noremap <silent> <C-f> :BLines <CR>
noremap <silent> <A-f> :Ag <CR>
noremap <silent> <C-t> :BTags <CR>

"" working with split windows
""" alt-arrows move around the split windows
tnoremap <A-Left> <C-\><C-N><C-w>h
tnoremap <A-Down> <C-\><C-N><C-w>j
tnoremap <A-Up> <C-\><C-N><C-w>k
tnoremap <A-Right> <C-\><C-N><C-w>l
inoremap <A-Left> <C-\><C-N><C-w>h
inoremap <A-Down> <C-\><C-N><C-w>j
inoremap <A-Up> <C-\><C-N><C-w>k
inoremap <A-Right> <C-\><C-N><C-w>l
nnoremap <A-Left> <C-w>h
nnoremap <A-Down> <C-w>j
nnoremap <A-Up> <C-w>k
nnoremap <A-Right> <C-w>l
""" toggle maximizing the current window
nnoremap <silent> <A-Enter> :ZoomWinTabToggle <CR>

"" esc cleans the slate
""" exit terminal mode
tnoremap <Esc> <C-\><C-n>
""" remove highlights
nnoremap <silent> <Esc> :nohl <CR> <Esc>
""" close stray fzf windows
autocmd! FileType fzf tnoremap <buffer> <Esc> <c-c>

" keep flags when repeating last :substitute
nnoremap & :&&<CR>
xnoremap & :&&<CR>

"" disable the q (recording) key binding
""" kept pressing it accidentally
noremap q <Nop>
