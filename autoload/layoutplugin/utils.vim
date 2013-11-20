if !exists('g:loaded_layoutplugin')
    runtime! plugin/layoutplugin.vim
endif
let g:loaded_layoutplugin = 1

let s:save_cpo = &cpo
set cpo&vim


function! layoutplugin#utils#make_replace_map(before, after)
    return { 'before' : a:before, 'after' : a:after }
endfunction


function! layoutplugin#utils#get_suffix_readme()
    return g:layoutplugin#is_suffix_readme_md == 1 ? '.md' : ''
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
