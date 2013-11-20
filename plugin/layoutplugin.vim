" Author: mopp

let s:save_cpo = &cpo
set cpo&vim


command! -nargs=1 LayoutPlugin call layoutplugin#make(expand(<f-args>))


let &cpo = s:save_cpo
unlet s:save_cpo
