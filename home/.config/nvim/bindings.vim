" commands
command! Focus call Focus()
command! Substitute call Substitute()
command! StripTrailingWhitespace call StripTrailingWhitespace()
command! DeleteInactiveBuffers call DeleteInactiveBuffers()
command! -nargs=+ -complete=command TabDo :call TabDo(<q-args>)
"" from: https://github.com/junegunn/fzf.vim#advanced-customization
command! -bang -nargs=* Rg call Rg(<q-args>, <bang>0)


" automatic commands
"" strip trailing whitespace on save
autocmd BufWritePre * StripTrailingWhitespace
"" treat .vue files like standard js files
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
"" disable line numbers in terminal windows
autocmd TermOpen * setlocal nonumber
"" make splits equal on resize
autocmd VimResized * TabDo wincmd =


" key bindings
"" general
nnoremap <silent> <C-n> :tabnew <CR>
nnoremap <silent> <A-n> :vs <CR>
noremap <silent> <C-s> :update <CR>
inoremap <silent> <C-s> <C-o>:update <CR>
noremap <silent> <C-z> u
inoremap <silent> <C-z> <C-o>u
noremap <silent> <C-q> :qall <CR>
noremap <silent> <C-a> ggvG$
noremap <silent> <C-h> :Substitute <CR>
nnoremap <silent> <nowait> <C-w> :bd <CR>
nnoremap <A-w> <C-w>

""" C-M == Ctrl+Enter
"""" if C-M doesn't work, to find what what it should be:
"""" enter bash and type ctrl+v followed by ctrl+enter
"""" it will give ^?, where ? is the character to use
noremap <silent> <C-M> :Focus <CR>

"" far
noremap <silent> <A-h> :Farp <CR>

"" fzf
noremap <silent> <C-o> :Files <CR>
noremap <silent> <C-b> :Buffers <CR>
noremap <silent> <C-f> :BLines <CR>
noremap <silent> <C-t> :BTags <CR>
noremap <silent> <A-f> :Rg <CR>

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
""" close other window types
autocmd! FileType help,far_vim,vim-plug noremap <buffer> <Esc> :bd <CR>

"" stops p from replacing the clipboard with the replaced text
""" from: https://stackoverflow.com/a/5093286 (rox's comment)
xnoremap <expr> p 'pgv"'.v:register.'y`>'

"" smart home
""" from: http://vim.wikia.com/wiki/Smart_home
"""" doesn't work if there's only an indent
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

"" kept pressing these accidentally
""" recording
noremap q <nop>
""" ex-mode
noremap Q <nop>

"" keep flags when repeating last :substitute
nnoremap & :&&<CR>
xnoremap & :&&<CR>

"" expand %% to current path in command mode
""" from: https://github.com/sheerun/vimrc
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
