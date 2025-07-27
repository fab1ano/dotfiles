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
set number
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
autocmd VimLeave * call system("xclip -in -selection clipboard", getreg('+'))

" Custom colors
hi TabLineSel term=bold cterm=bold ctermfg=white ctermbg=0
hi TabLine term=none cterm=none ctermfg=gray ctermbg=0
hi TabLineFill term=none cterm=none ctermfg=gray ctermbg=0

hi SpecialKey ctermbg=none

" Fix current line number
hi CursorLineNR ctermbg=lightgrey cterm=None

" Hide EndOfBuffer (tilde)
set fillchars+=eob:\ 

" Line overlength
highlight OverLength ctermbg=7
match OverLength /\%81v./

" Load the lua configuration file
luafile ~/.vim/init.lua

" Strip trailing whitespaces on save
function! <SID>StripTrailingWhitespaces()
  if !&binary && &filetype != 'diff'
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endif
endfun

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Mappings for neo-tree
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap , :Neotree<CR>
nnoremap – :Neotree git_status<CR>
