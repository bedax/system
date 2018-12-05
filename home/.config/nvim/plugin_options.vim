" fzf
"" fd ignores .gitignore's stuff by default, and it's faster
let $FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow"

" far
"let g:far#source = 'rgnvim'
let g:far#window_layout = 'bottom'
let g:far#preview_window_layout = 'right'
let g:far#result_preview = 1
let g:far#limit = 100000
"" at the moment rgnvim uses `rg -t` instead of `--glob` for the file-mask
let g:far#source = 'vimgrep'
set wildignore=/**/node_modules/**

" nvim-completion-manager
let g:cm_complete_popup_delay = 60
let g:cm_refresh_default_min_word_len = 1
let g:cm_matcher = {'module': 'cm_matchers.prefix_matcher', 'case': 'case'}


" lightline
let g:lightline = {
\   'colorscheme': 'gruvbox',
\   'active': {
\      'left': [['mode', 'paste'], ['readonly', 'filename', 'modified']],
\      'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
\   }
\}
"" don't show the default mode indicator
set noshowmode
""" needed to hide unnecessary information shown by noshowmode
"set shortmess+=c

" rust.vim
let g:rust_recommended_style = 0

" vim-rooter
let g:rooter_silent_chdir = 1
let g:rooter_change_directory_for_non_project_files = 'home'

" zoomwintab
"" this enabled was delaying the ctrl+w remapping
let g:zoomwintab_remap = 0
