"=============================================================================
" File: {REPLACE_PLUGIN_NAME_WITH_SUFFIX}
" Author: {REPLACE_USER_NAME}
" Created: {REPLACE_DATE}
"=============================================================================

scriptencoding utf-8

if exists('g:loaded_{REPLACE_PLUGIN_NAME}')
    finish
endif
let g:loaded_{REPLACE_PLUGIN_NAME} = 1

let s:save_cpo = &cpo
set cpo&vim



let &cpo = s:save_cpo
unlet s:save_cpo
