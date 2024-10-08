" This is just an initial stripped-down version of the actual vimrc

source ~/.vim/plugins.vim

if has('nvim')
  source ~/.vim/neo.vim
endif


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
nnoremap <C-n>  :Files<CR>
nnoremap <C-p>  :tabe<CR>:Files<CR>

" Enable project specific config files
set exrc

" Enable filetype plugin
filetype plugin indent on

" Allow more than 10 tabs to be open
set tabpagemax=20

" Set mouse to GUI mode
set mouse=a
" Let the terminal handle C-LeftMouse to open links
noremap <C-LeftMouse> <LeftMouse>

" Solarized colortheme
let g:solarized_termtrans=1
if has('nvim')
  set termguicolors
  set background=light
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum
  let g:neosolarized_bold = 1
  let g:neosolarized_italic = 1
"  let g:neosolarized_visibility = "low"
  let g:neosolarized_termtrans = 1
  colorscheme NeoSolarized
else
  colorscheme solarized
endif

" YCM disable preview in separate window
set completeopt-=preview

" Keep clip board on exit
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" Custom colors
hi TabLineSel term=bold cterm=bold ctermfg=white ctermbg=0
hi TabLine term=none cterm=none ctermfg=gray ctermbg=0
hi TabLineFill term=none cterm=none ctermfg=gray ctermbg=0

hi SpecialKey ctermbg=none

" Fix current line number
hi CursorLineNR ctermbg=lightgrey cterm=None

" Hide EndOfBuffer (tilde)
hi EndOfBuffer ctermfg=0 ctermbg=none

" Line overlength
highlight OverLength ctermbg=7
match OverLength /\%81v./
