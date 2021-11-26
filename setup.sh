#!/usr/bin/env bash

# Exit on error
set -e


# Clone repository if necessary
sudo apt install git

if [[ -z ${BASH_SOURCE}  ]]; then
	# We need to clone the repository
	git clone https://github.com/fab1ano/dotfiles .dotfiles
	cd .dotfiles
else
	# We assume that the repository is already cloned
	cd "$(dirname "${BASH_SOURCE}")";
fi


# Install dependencies
sudo apt install -y gdb htop python3 python3-pip tmux vim virtualenv xclip zsh wget


# Link all configs
pushd home

# Remove all initialized submodules
failed_submodules=$(git submodule deinit . 2>&1)
if [[ $failed_submodules == *"could not create empty submodule directory"*  ]]; then
	echo "git submodule deinit failed"
	exit
fi

# Create required directories
find . -type d | xargs -I {} mkdir -p ~/{}

# Link config files
find . -type f -printf '%P\n' | xargs -I {} ln -sf ${PWD}/{} ~/{}

# Link submodules
git submodule status -- . | awk '{ print $2  }' | xargs -I {} sh -c "rm -rf ~/{}; ln -sf ${PWD}/{} ~/{}"

# Update submodules
git submodule update --init --recursive .

popd


# Install GEF
wget https://raw.githubusercontent.com/hugsy/gef/dev/gef.py -O ~/.gdbinit-gef.py

# Install Vim solarized theme
mkdir -p ~/.vim/colors
wget https://raw.githubusercontent.com/altercation/solarized/master/vim-colors-solarized/colors/solarized.vim -O ~/.vim/colors/solarized.vim

# Install virtualenvwrapper
pip install virtualenvwrapper
