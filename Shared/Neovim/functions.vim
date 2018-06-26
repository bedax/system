" easy search and replace
fun! Substitute()
   let search = input('Search for: ')
   if search != ''
      let replace = input('Replace with: ')
      execute ':%s/'.search.'/'.replace.'/gcI'
   endif
endfun


fun! Focus()
   " cursorline should be enabled if we're not in Focus mode
   if &cursorline
      :Goyo
      :set cursorline!
   else
      :Goyo!
      :set cursorline
   endif
endfun


" like fzf's :Ag but using ripgrep
"" from: https://github.com/junegunn/fzf.vim#advanced-customization
fun! Rg(q_args, bang_0)
   call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --color=always
      \    '.shellescape(a:q_args), 1,
      \ a:bang_0 ? fzf#vim#with_preview('up:60%')
      \          : fzf#vim#with_preview('right:50%:hidden', '?'),
      \ a:bang_0
   \ )
endfun


" from: http://vimcasts.org/episodes/tidying-whitespace/
fun! StripTrailingWhitespace()
   " Preparation: save last search, and cursor position.
   let _s=@/
   let l = line(".")
   let c = col(".")
   " Do the business:
   %s/\s\+$//e
   " Clean up: restore previous search history, and cursor position
   let @/=_s
   call cursor(l, c)
endfun


" from: https://stackoverflow.com/a/7321131
fun! DeleteInactiveBuffers()
   " From tabpagebuflist() help, get a list of all buffers in all tabs
   let tablist = []
   for i in range(tabpagenr('$'))
      call extend(tablist, tabpagebuflist(i + 1))
   endfor

   " Below originally inspired by Hara Krishna Dara and Keith Roberts
   " http://tech.groups.yahoo.com/group/vim/message/56425
   let nWipeouts = 0
   for i in range(1, bufnr('$'))
      " bufno exists AND isn't modified AND isn't in the list of buffers open
      " in windows and tabs
      if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
         silent exec 'bwipeout' i
         let nWipeouts = nWipeouts + 1
      endif
   endfor
   echomsg nWipeouts.' buffer(s) removed'
endfun
