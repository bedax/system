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

" long-line marker, changing the background colour
let &colorcolumn=join(range(80,999),",")

" have the arrow keys change lines
set whichwrap+=<,>,h,l,[,]

" dash as a word separator
set iskeyword+=-

" fixes slow scrolling
set lazyredraw

" tabpages and globals are needed by Taboo to persist tab names
set sessionoptions+=tabpages,globals,localoptions

" fish can cause problems
if &shell =~# 'fish$'
    set shell=/bin/bash
endif

set noerrorbells
set visualbell

" disable those vim lines some files have; they can be a security risk
set nomodeline

set foldmethod=indent
set foldnestmax=3
set nofoldenable

set noswapfile

" indents
set autoindent
"" tab's (\t) visual width
set tabstop=4
"" use spaces for indents
set expandtab
"" how many columns do the indentation operations adjust by (<< and >>)
""" if == 0: use tabstop
set shiftwidth=0
"" how many columns a tab is in insert mode
""" if != tabstop and not expandtabs: uses a combination of tabs and spaces
""" if == -1: use shiftwidth
""" if == 0: disable
set softtabstop=0
"" when tab is used in the 'front' of a line, use shiftwidth
set nosmarttab
