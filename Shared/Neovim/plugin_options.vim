" theme
colorscheme gruvbox
set background=dark
"" theme-specific options
let g:gruvbox_number_column = 'bg1'
let g:gruvbox_invert_selection = 0
let g:gruvbox_invert_tabline = 0
let g:gruvbox_improved_strings = 1
let g:gruvbox_improved_warnings = 1
"" fixes gruvbox's colours
set termguicolors
"" stops "::" in rust from having a different background colour
""" the BufEnter bit was added because GoyoLeave was resetting it
autocmd FileType rust autocmd BufEnter <buffer>
    \ highlight Delimiter ctermfg=208 ctermbg=0 guifg=#fe8019 guibg=0

" fzf
"" fd ignores .gitignore's stuff by default, and it's faster
let $FZF_DEFAULT_COMMAND = "fd --follow --hidden ."

" far
let g:far#source = 'vimgrep'
let g:far#window_layout = 'bottom'
let g:far#preview_window_layout = 'right'
let g:far#result_preview = 1
let g:far#limit = 1000000
"" use rgnvim to ignore .gitignore; support is coming in the beta
set wildignore=/**/node_modules/**

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
