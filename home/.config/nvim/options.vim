" use unix line-endings
set fileformat=unix

" syntax highlighting
syntax on
" fixes the problem where the highlighting stops working
"autocmd FileType vue syntax sync fromstart

" if plugin and indent are on, python files override the global indenting
filetype on
filetype indent off
filetype plugin off

" fixes slow scrolling
set lazyredraw

" mouse support
set mouse=a

" disable some quirks from vi
set nocompatible

" line numbers
set number

" make sure the cursor always has X number of lines around it when scrolling
set scrolloff=0
"" horizontal
set sidescrolloff=0

" wrap lines without real breaks
set wrap
" don't break up words when wrapping
set linebreak
" don't hard break long lines
set textwidth=0

" have the backspace key delete indents
set backspace=indent,eol,start

" have the arrow keys change lines
set whichwrap+=<,>,h,l,[,]

" dash as a word separator
set iskeyword+=-

" automatically reload the file if it's changed with no changes internally
set autoread

" timing between keypresses of key combinations
set ttimeout
set ttimeoutlen=100

" show how much has been selected in visual mode
set showcmd

" override a search's ignorecase option if the search contains uppercase
set ignorecase
set smartcase

" use the global clipboard
set clipboard=unnamedplus

" highlight current line
set cursorline

" highlighting searches
set hlsearch

" splits equalise when one is added or removed
set equalalways

" open buffers on the right pane of a new split
set splitright

" long-line marker, changing the background colour
let &colorcolumn=join(range(80,999),",")

" tabpages and globals are needed by Taboo to persist tab names
set sessionoptions+=tabpages,globals,localoptions

set noerrorbells
set visualbell

" disable those vim lines some files have;
" they can be a security risk
set nomodeline

set foldmethod=indent
set foldnestmax=3
set nofoldenable

"set noswapfile

set listchars=tab:>~,nbsp:_
set list

" persistent undos across buffer switches
set undofile
let &undodir = local_directory.'/undo'
silent call system('rm -f '.&undodir.'/*')
silent call system('mkdir -p '.&undodir)

" indents
set autoindent
"" tab's (\t) visual width
set tabstop=3
"" use spaces for indents
set expandtab
"" how many columns do the indentation operations adjust by (<< and >>)
set shiftwidth=0
"" how many columns a tab is in insert mode
set softtabstop=3
"" when tab is used in the 'front' of a line, use shiftwidth
set nosmarttab

" fish can cause problems
if &shell =~# 'fish$'
    set shell=/bin/bash
endif
