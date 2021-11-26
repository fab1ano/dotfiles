"""""""""" PLUGINS """"""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

"Plugin 'tpope/vim-fugitive'
"Plugin 'git://git.wincent.com/command-t.git'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'jiangmiao/auto-pairs'
"Plugin 'jeaye/color_coded'
"Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf'
Plugin 'tpope/vim-eunuch'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required



"""""""""" BASICS """"""""""
" highlighted search
set hlsearch

" tabs
set list
set listchars=tab:\|\ ,trail:·
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

" enable syntax
syntax on

" corsorline/-column and linenumbers
set relativenumber
set cursorline
set cursorcolumn

" scroll offset
set scrolloff=10

" enable verbose tab completion
set wildmenu

" enable file specific configs
set modeline

" custom indentation
autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType eruby setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType scss setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType java setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType c setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType cpp setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab

" open files
nnoremap <leader>o  :Files<CR>
nnoremap <leader>O  :tabe<CR>:Files<CR>

" enable project specific config files
set exrc

"""""""""" YCM """"""""""
" change warnings for ycm
let g:ycm_max_diagnostics_to_display = 1000
let g:ycm_warning_symbol = '>'
let g:ycm_error_symbol = '>'

let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_auto_trigger = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_always_populate_location_list = 1

set completeopt-=preview

nmap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <leader>t  :YcmCompleter GetType<CR>
nmap <leader>f  :YcmCompleter FixIt<CR>
nmap <leader>n  :lnext<CR>
nmap <leader>p  :lprevious<CR>

"""""""""" COLORS """"""""""
" enable solarized colortheme
colorscheme solarized

" Custom colors
hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=194
hi CursorLineNr ctermbg=194

hi CursorLine term=none cterm=none ctermbg=194
hi CursorColumn ctermbg=194

hi SignColumn ctermbg=194

hi TabLineSel term=bold cterm=bold ctermfg=255 ctermbg=0
hi TabLine term=none cterm=none ctermfg=245 ctermbg=0
hi TabLineFill term=bold cterm=bold ctermfg=245 ctermbg=0

hi SpecialKey ctermbg=none

" ycm
hi YcmWarningLine ctermbg=none
hi YcmWarningSign ctermbg=194
hi YcmWarningSection ctermbg=194
hi YcmErrorLine ctermbg=none
hi YcmErrorSign ctermbg=194 ctermfg=red
hi YcmErrorSection ctermbg=194 ctermfg=red

" hide EndOfBuffer (tilde)
hi EndOfBuffer ctermfg=bg

" line overlength
highlight OverLength ctermbg=194
match OverLength /\%81v./
