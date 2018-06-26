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

   " language support
   "" rust
   Plug 'https://github.com/rust-lang/rust.vim.git'
   "" scss
   Plug 'https://github.com/cakebaker/scss-syntax.vim'
   "" javascript
   Plug 'https://github.com/pangloss/vim-javascript.git'
   "" vue components
   Plug 'https://github.com/posva/vim-vue'
   "" fish
   Plug 'https://github.com/dag/vim-fish'
   "" toml
   Plug 'https://github.com/cespare/vim-toml'

   " completions
   Plug 'https://github.com/roxma/nvim-completion-manager.git'
   "" basic generic syntax completions for all vim-supported languages
   Plug 'https://github.com/Shougo/neco-syntax.git'
   "" complete words from other buffers
   Plug 'https://github.com/fgrsnau/ncm-otherbuf.git'
   "" rust
   Plug 'https://github.com/racer-rust/vim-racer.git'
   Plug 'https://github.com/roxma/nvim-cm-racer.git'
   "" css
   Plug 'https://github.com/calebeby/ncm-css.git'
   "" js; flow requires per-project configuration
   Plug 'https://github.com/roxma/nvim-cm-tern.git',
      \ {'do': 'npm install'}

   " session management
   Plug 'https://github.com/tpope/vim-obsession.git'

   " fuzzy finder
   Plug 'https://github.com/junegunn/fzf.git',
      \ { 'dir': opt_directory.'fzf', 'do': './install --bin' }
   "" vim integration
   Plug 'https://github.com/junegunn/fzf.vim.git'

   " git support
   "" for fzf's :Commits command, and airline
   Plug 'https://github.com/tpope/vim-fugitive.git'

   " minimalist writing
   Plug 'https://github.com/junegunn/goyo.vim'

   " status line
   Plug 'https://github.com/vim-airline/vim-airline.git'

   " search and replace across files
   Plug 'https://github.com/brooth/far.vim.git'

   " rename tabs
   Plug 'https://github.com/gcmt/taboo.vim.git'

   " close buffers, leaving the window intact
   Plug 'https://github.com/qpkorr/vim-bufkill'

   " maximise a window when using splits
   Plug 'https://github.com/troydm/zoomwintab.vim.git'

   " word counter
   Plug 'https://github.com/ChesleyTan/wordCount.vim'

   " disable capslock in normal mode
   Plug 'https://github.com/suxpert/vimcaps.git'

   " change the current directory to the project's
   Plug 'https://github.com/airblade/vim-rooter.git'

   " debugger
   "Plug 'https://github.com/dbgx/lldb.nvim.git'

   " automated swap-file handling
   Plug 'https://github.com/gioele/vim-autoswap'
call plug#end()
