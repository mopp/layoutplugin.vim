if !exists('g:loaded_layoutplugin')
    runtime! plugin/layoutplugin.vim
endif
let g:loaded_layoutplugin = 1

let s:save_cpo = &cpo
set cpo&vim

" config
let g:layoutplugin#user_name                = get(g:, 'layoutplugin#user_name', $USER)
let g:layoutplugin#is_append_vimrc          = get(g:, 'layoutplugin#is_append_vimrc', 0)
let g:layoutplugin#is_suffix_readme_md      = get(g:, 'layoutplugin#is_suffix_readme_md ', 1)
let g:layoutplugin#is_suffix_plugin_name    = get(g:, 'layoutplugin#is_suffix_plugin_name', 1)
let g:layoutplugin#replace_dict             = {
            \ 'plugin_name' : layoutplugin#utils#make_replace_map('{REPLACE_PLUGIN_NAME}', g:layoutplugin#user_name),
            \ 'auther'      : layoutplugin#utils#make_replace_map('{REPLACE_USER_NAME}', g:layoutplugin#user_name),
            \ 'date'        : layoutplugin#utils#make_replace_map('{REPLACE_DATE}', strftime('%Y-%m-%d')),
            \ }

let s:source_dir            = expand("<sfile>:p:h") . '/../source/'
let s:source_plugin_path    = s:source_dir . 'templete_plugin.vim'
let s:source_autoload_path  = s:source_dir . 'templete_autoload.vim'
let s:source_readme_path    = s:source_dir . 'templete_README' . layoutplugin#utils#get_suffix_readme()
let s:copy_command          = (has('win32')) ? ('copy') : ('cp')


function! s:replace_copy_file(source, destination)
    let source_data = readfile(a:source)

    for key in keys(g:layoutplugin#replace_dict)
        let before = g:layoutplugin#replace_dict[key]['before']
        let after = g:layoutplugin#replace_dict[key]['after']

        " XXX
        call map(source_data, "substitute(v:val, '" . before . "', '" . after . "', 'g')")
    endfor

    call writefile(source_data, a:destination)

    nohlsearch
endfunction


function! layoutplugin#make(plugin_name)
    " set plugin name for replacement
    let no_suffix = substitute(a:plugin_name, '\.vim', '', 'g')
    if g:layoutplugin#is_suffix_plugin_name == 1
        let name = no_suffix . '.vim'
    else
        let name = a:plugin_name
    endif

    let g:layoutplugin#replace_dict['plugin_name_suffix'] = layoutplugin#utils#make_replace_map('{REPLACE_PLUGIN_NAME_WITH_SUFFIX}', name)
    let g:layoutplugin#replace_dict['plugin_name'] = layoutplugin#utils#make_replace_map('{REPLACE_PLUGIN_NAME}', no_suffix)

    " define dir and path
    let target_base_dir = getcwd() . '/' . name . '/'
    let target_plugin_path = target_base_dir.'plugin/' . name
    let target_autoload_path = target_base_dir.'autoload/' . name
    let target_readme_path = target_base_dir.'README' . layoutplugin#utils#get_suffix_readme()

    " make plugin dir and file
    call mkdir(target_base_dir . 'plugin', 'p')
    call s:replace_copy_file(s:source_plugin_path, target_plugin_path)

    " make autoload dir and file
    call mkdir(target_base_dir . 'autoload')
    call s:replace_copy_file(s:source_autoload_path, target_autoload_path)

    " make readme file
    call s:replace_copy_file(s:source_readme_path, target_readme_path)

    if g:layoutplugin#is_append_vimrc == 1
        let isFaild = writefile(add(readfile($MYVIMRC), "set runtimepath+=" . target_base_dir), $MYVIMRC)
        if isFaild == -1
            throw "cannot write vimrc"
        endif
    endif

    echomsg 'Genereted in ' . target_base_dir
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
