" This is just an initial stripped-down version of the actual vimrc
" TODO: update this

set nocompatible
filetype off

" highlighted search
set hlsearch

" tabs
set list
set listchars=tab:\|\ 
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

" open files
nnoremap <leader>o  :Files<CR>
nnoremap <leader>O  :tabe<CR>:Files<CR>

" enable project specific config files
set exrc

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

" hide EndOfBuffer (tilde)
hi EndOfBuffer ctermfg=0 ctermbg=none

" line overlength
highlight OverLength ctermbg=194
match OverLength /\%81v./
