function! quickpick#pickers#colorschemes#show(...) abort
    let initial_colorscheme = get(g:, 'colors_name', 'default')
    let id = quickpick#create({
        \   'on_change': function('s:on_change'),
        \   'on_cancel': function('s:on_cancel', [initial_colorscheme]),
        \   'on_accept': function('s:on_accept'),
        \   'on_selection_change': function('s:on_selection_change'),
        \   'items': s:get_colorschemes(0),
        \ })
    call quickpick#show(id)
    return id
endfunction

function! s:get_colorschemes(refresh) abort
    if !exists('s:colorschemes') || a:refresh
        let s:colorschemes = uniq(map(split(globpath(&rtp, "colors/*.vim"), "\n"), "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"))
    endif
    return s:colorschemes
endfunction

function! s:on_change(id, action, searchterm) abort
    let searchterm = tolower(trim(a:searchterm))
    let items = empty(searchterm) ? s:get_colorschemes(0) : filter(copy(s:get_colorschemes(0)), {index, item-> stridx(tolower(item), searchterm) > -1})
    call quickpick#set_items(a:id, items)
endfunction

function! s:on_selection_change(id, action, data) abort
    if !empty(a:data['items'])
        execute 'colorscheme ' . a:data['items'][0]
    endif
endfunction

function! s:on_cancel(inital_colorscheme, id, action, data) abort
    execute 'colorscheme ' . a:inital_colorscheme
endfunction

function! s:on_accept(id, action, data) abort
    call quickpick#close(a:id)
    execute 'colorscheme ' . a:data['items'][0]
endfunction
