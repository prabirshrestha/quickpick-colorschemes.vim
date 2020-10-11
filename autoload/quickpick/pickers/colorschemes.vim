function! quickpick#pickers#colorschemes#open() abort
  let l:initial_colorscheme = get(g:, 'colors_name', 'default')
  call quickpick#open({
    \ 'items': uniq(map(split(globpath(&rtp, "colors/*.vim"), "\n"), "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')")),
    \ 'on_accept': function('s:on_accept'),
    \ 'on_selection': function('s:on_selection'),
    \ 'on_cancel': function('s:on_cancel', [l:initial_colorscheme]),
    \ })
endfunction

function! s:on_accept(data, ...) abort
  call quickpick#close()
  execute 'colorscheme ' . a:data['items'][0]
endfunction

function! s:on_selection(data, ...) abort
  if !empty(a:data['items'])
    execute 'colorscheme ' . a:data['items'][0]
  endif
endfunction

function! s:on_cancel(inital_colorscheme, data, ...) abort
  if !empty(a:inital_colorscheme)
    execute 'colorscheme ' . a:inital_colorscheme
  endif
endfunction

" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldmethod=marker spell:
