" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plugins
call plug#begin('~/.vim/plugged')

"Plug 'tpope/vim-fugitive'
"Plug 'git://git.wincent.com/command-t.git'
"Plug 'jeaye/color_coded'
"Plug 'vim-syntastic/syntastic'
"Plug 'jiangmiao/auto-pairs'
"Plug 'tpope/vim-surround'

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'tpope/vim-eunuch'

"Plug 'ycm-core/YouCompleteMe'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'udalov/kotlin-vim'


Plug 'farmergreg/vim-lastplace'

Plug 'thesis/vim-solidity', {'branch': 'main' }

if has('nvim')
  Plug 'overcache/NeoSolarized'

  Plug 'github/copilot.vim'
endif

call plug#end()
