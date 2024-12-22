" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plugins
call plug#begin('~/.vim/plugged')

" Fuzzy file search
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'

" Shell commands
Plug 'tpope/vim-eunuch'

" Automatically set shiftwidth and expandtab for files
Plug 'tpope/vim-sleuth'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Kotlin support
Plug 'udalov/kotlin-vim'

" Open files at the last cursor position
Plug 'farmergreg/vim-lastplace'

" Support for Solidity
Plug 'thesis/vim-solidity', {'branch': 'main' }

" Some plugins only supported in NeoVim
if has('nvim')
  " Solarized theme for NeoVim
  Plug 'overcache/NeoSolarized'

  " Copilot
  Plug 'github/copilot.vim'

  " Centered view
  Plug 'shortcuts/no-neck-pain.nvim', { 'tag': '*' }
endif

call plug#end()
