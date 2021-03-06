function! quickpick#pickers#colorschemes#open() abort
  let l:initial_colorscheme = get(g:, 'colors_name', 'default')
  call quickpick#open({
    \ 'items': uniq(map(split(globpath(&rtp, "colors/*.vim"), "\n"), "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')")),
    \ 'on_accept': function('s:on_accept'),
    \ 'on_selection': function('s:on_selection', [l:initial_colorscheme]),
    \ 'on_cancel': function('s:on_cancel', [l:initial_colorscheme]),
    \ })
endfunction

function! s:on_accept(data, ...) abort
  call quickpick#close()
  execute 'colorscheme ' . a:data['items'][0]
endfunction

function! s:on_selection(initial_colorscheme, data, ...) abort
  if empty(a:data['items'])
    execute 'colorscheme ' . a:initial_colorscheme
  else
    execute 'colorscheme ' . a:data['items'][0]
  endif
endfunction

function! s:on_cancel(initial_colorscheme, data, ...) abort
  if !empty(a:initial_colorscheme)
    execute 'colorscheme ' . a:initial_colorscheme
  endif
endfunction

" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldmethod=marker spell:
