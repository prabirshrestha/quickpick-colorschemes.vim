if exists('g:quickpick_colorschemes')
    finish
endif
let g:quickpick_colorschemes = 1

command! Pcolorschemes call quickpick#pickers#colorschemes#show()
