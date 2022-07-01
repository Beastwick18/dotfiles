" Test function for a plugin I'm working on
if exists('g:loaded_window_submode')
    finish
endif
let g:loaded_window_submode = 1

function! window_submode#WindowSubmodeKeybinds()
    let g:submode_always_show_submode = 1

    " Enter and exit window submode
    call submode#enter_with('window', 'n', '', '<C-w>')
    call submode#leave_with('window', 'n', '', '<ESC>')

    " Map all alpha keys
    for key in ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
        call submode#map('window', 'n', '', key, '<C-w>' . key)
        call submode#map('window', 'n', '', toupper(key), '<C-w>' . toupper(key))
        call submode#map('window', 'n', '', '<C-' . key . '>', '<C-w>' . '<C-w>' . '<C-' . key . '>')
    endfor

    " Resize symbols
    for key in ['=', '_', '+', '-', '<', '>']
        call submode#map('window', 'n', '', key, '<C-w>' . key)
    endfor
    
    let g:submode_timeout = 0

    " " Remap leader w to ctrl w, since it easier to type
    " " This would be included in a vimrc, not the plugin
    " nnoremap <leader>w <C-w>
endfunction
