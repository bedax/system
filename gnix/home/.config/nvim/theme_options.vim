colorscheme gruvbox
set background=dark

" theme-specific options
let g:gruvbox_number_column = 'bg1'
let g:gruvbox_invert_selection = 0
let g:gruvbox_invert_tabline = 0
let g:gruvbox_improved_strings = 1
let g:gruvbox_improved_warnings = 1

" fixes gruvbox's colours
set termguicolors


" stops things from having a lighter background colour when using gruvbox-dark
fun! UnhighlightGruboxBackground(file_type, highlight_group)
   " the BufEnter bit was added because GoyoLeave was resetting it
   execute '
      \ autocmd FileType '.a:file_type.'
         \ autocmd BufEnter <buffer>
            \ highlight '.a:highlight_group.'
               \ ctermfg=208 ctermbg=0 guifg=#fe8019 guibg=0'
endfun

"" "::" in rust
call UnhighlightGruboxBackground('rust', 'Delimiter')
"" lifetimes in rust
call UnhighlightGruboxBackground('rust', 'Special')
