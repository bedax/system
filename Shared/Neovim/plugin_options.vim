" theme
colorscheme gruvbox
set background=dark
"" theme-specific options
let g:gruvbox_number_column='bg1'
let g:gruvbox_invert_selection=0
let g:gruvbox_invert_tabline=0
let g:gruvbox_improved_strings=1
let g:gruvbox_improved_warnings=1
"" fixes gruvbox's colours
set termguicolors

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

"" which js libraries to highlight the syntax of
""" see: https://github.com/othree/javascript-libraries-syntax.vim
"""" also supports 'vue' if vim-vue doesn't do it
let g:used_javascript_libs = 'underscore,jquery'
