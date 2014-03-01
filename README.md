## LayoutPlugin.vim
This is Vim Plugin for generate plugin directory and files.

## Installation
```vim
NeoBundleLazy 'mopp/layoutplugin.vim', { 'autoload' : { 'commands' : 'LayoutPlugin'} }
```

## Configure
g:layoutplugin#is_suffix_plugin_name  
LayoutPlugin automatically adds suffix '.vim'.  
default: 1  

g:layoutplugin#is_append_vimrc  
Layoutplugin automatically adds plugin path into your vimrc.  
default: 0  
