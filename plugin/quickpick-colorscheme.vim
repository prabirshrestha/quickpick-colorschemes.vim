if exists('g:quickpick_colorscheme')
    finish
endif
let g:quickpick_colorscheme = 1

command! Pcolorscheme call quickpick#pickers#colorscheme#show()
