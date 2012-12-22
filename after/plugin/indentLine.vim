" Script Name: indentLine.vim
" Version:     1.0.2
" Last Change: Dec 22, 2012
" Author:      Yggdroot <archofortune@gmail.com>
"
" Description: To show the indent line

if !has("conceal") || exists("g:loaded_indentLine")
    finish
endif
let g:loaded_indentLine = 1
if !exists("g:indentLine_char")
    " | ¦ ┆  │
    let g:indentLine_char = "|"
endif

if !exists("g:indentLine_indentLevel")
    let g:indentLine_indentLevel = 20
endif

set conceallevel=1
set concealcursor=inc

function! <SID>InitColor()
    if !exists("g:indentLine_color_term")
        if &bg ==? "light"
            let term_color = 238
        else
            let term_color = 039
        endif
    else
        let term_color = g:indentLine_color_term
    endif

    if !exists("g:indentLine_color_gui")
        if &bg ==? "light"
            let gui_color = "Grey"
        else
            let gui_color = "Grey40"
        endif
    else
        let gui_color = g:indentLine_color_gui
    endif

    exec "hi Conceal ctermfg=" . term_color . " ctermbg=NONE"
    exec "hi Conceal guifg=" . gui_color .  " guibg=NONE"
endfunction

function! <SID>SetIndentLine()
    let space = &l:shiftwidth
    for i in range(space+1, space * g:indentLine_indentLevel + 1, space)
        exec 'syn match IndentLine /\(^\s\+\)\@<=\%'.i.'v / containedin=ALL conceal cchar=' . g:indentLine_char
    endfor
endfunction

autocmd BufRead * call <SID>SetIndentLine()
autocmd BufRead,ColorScheme * call <SID>InitColor()


" vim:et:ts=4:sw=4:fdm=marker:fmr={{{,}}}