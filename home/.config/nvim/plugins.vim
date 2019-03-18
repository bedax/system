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
   Plug 'https://github.com/morhetz/gruvbox'

   " language support
   "" rust
   Plug 'https://github.com/rust-lang/rust.vim'
   "" scss
   Plug 'https://github.com/cakebaker/scss-syntax.vim'
   "" javascript
   Plug 'https://github.com/pangloss/vim-javascript'
   "" vue components
   Plug 'https://github.com/posva/vim-vue'
   "" fish
   Plug 'https://github.com/dag/vim-fish'
   "" toml
   Plug 'https://github.com/cespare/vim-toml'

   " completions
"   Plug 'https://github.com/roxma/nvim-completion-manager'
   "" basic generic syntax completions for all vim-supported languages
"   Plug 'https://github.com/Shougo/neco-syntax'
   "" complete words from other buffers
"   Plug 'https://github.com/fgrsnau/ncm-otherbuf'
   "" rust
"   Plug 'https://github.com/racer-rust/vim-racer'
"   Plug 'https://github.com/roxma/nvim-cm-racer'
   "" css
"   Plug 'https://github.com/calebeby/ncm-css'
   "" js; flow requires per-project configuration
"   Plug 'https://github.com/roxma/nvim-cm-tern',
"      \ {'do': 'npm install'}

   " session management
   Plug 'https://github.com/tpope/vim-obsession'

   " fuzzy finder
   Plug 'https://github.com/junegunn/fzf',
      \ { 'dir': opt_directory.'/fzf', 'do': './install --bin' }
   "" vim integration
   Plug 'https://github.com/junegunn/fzf.vim'

   " git support
   "" for fzf's :Commits command, and airline
   Plug 'https://github.com/tpope/vim-fugitive'

   " minimalist writing
   Plug 'https://github.com/junegunn/goyo.vim'

   " status line
   Plug 'https://github.com/itchyny/lightline.vim'

   " search and replace across files
   Plug 'https://github.com/brooth/far.vim'

   " rename tabs
   Plug 'https://github.com/gcmt/taboo.vim'

   " close buffers, leaving the window intact
   Plug 'https://github.com/qpkorr/vim-bufkill'

   " maximise a window when using splits
   Plug 'https://github.com/troydm/zoomwintab.vim'

   " word counter
   Plug 'https://github.com/ChesleyTan/wordCount.vim'

   " automated swap-file handling
   Plug 'https://github.com/gioele/vim-autoswap'

   " automatic directory changing
   Plug 'https://github.com/airblade/vim-rooter'

call plug#end()
