" This is just an initial stripped-down version of the actual vimrc
" TODO: update this

source ~/.vim/plugins.vim

" Highlighted search
set hlsearch

" Tabs
set list
set listchars=tab:\|\ 
set tabstop=4 shiftwidth=4

" Corsorline/-column and linenumbers
set relativenumber
set cursorline
set cursorcolumn

" Scroll offset
set scrolloff=10

" Enable verbose tab completion
set wildmenu

" Enable file specific configs
set modeline

" Open files
nnoremap <leader>o  :Files<CR>
nnoremap <leader>O  :tabe<CR>:Files<CR>

" Enable project specific config files
set exrc

" Solarized colortheme
let g:solarized_termtrans=1
colorscheme solarized

" YCM disable preview in separate window
set completeopt-=preview

" Custom colors
hi TabLineSel term=bold cterm=bold ctermfg=white ctermbg=0
hi TabLine term=none cterm=none ctermfg=gray ctermbg=0
hi TabLineFill term=none cterm=none ctermfg=gray ctermbg=0

hi SpecialKey ctermbg=none

" Hide EndOfBuffer (tilde)
hi EndOfBuffer ctermfg=0 ctermbg=none

" Line overlength
highlight OverLength ctermbg=7
match OverLength /\%81v./
