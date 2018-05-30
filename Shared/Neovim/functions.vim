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
