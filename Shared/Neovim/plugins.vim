" extended % matching for HTML, etc
"" requires`filetype plugin on`
runtime macros/matchit.vim


" install the plugin manager if it's not already installed
if empty(glob(local_directory.'/site/autoload/plug.vim'))
    silent execute '!curl --create-dirs --fail --location '.
        \ '--output '.local_directory.'/site/autoload/plug.vim '.
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" plugins
call plug#begin(local_directory.'/plugged')

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

    " session management
    Plug 'https://github.com/tpope/vim-obsession.git'

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

    " copy history
    "Plug 'https://github.com/bfredl/nvim-miniyank.git'

    " debugger
    "Plug 'https://github.com/dbgx/lldb.nvim.git'

    " status line
    Plug 'https://github.com/vim-airline/vim-airline.git'

    " disable capslock in normal mode
    Plug 'https://github.com/suxpert/vimcaps.git'

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

    " use ale or neomake for syntax checking
    "" ale checks the buffer's content, neomake checks the saved file

    " surround stuff
    "Plug 'https://github.com/tpope/vim-surround.git'

    " current word highlighter, with support for different highlights at once
    "Plug 'https://github.com/lfv89/vim-interestingwords.git'

call plug#end()
