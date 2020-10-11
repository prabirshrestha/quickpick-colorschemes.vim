if exists('g:quickpick_colorschemes_loaded')
    finish
endif
let g:quickpick_colorschemes_loaded = 1

command! Pcolorchemes call quickpick#pickers#colorschemes#open()
