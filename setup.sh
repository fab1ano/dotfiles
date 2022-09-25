#!/usr/bin/env bash

# Exit on error
set -e


# Check if X-Server is running
if command -v xset &> /dev/null && xset q &> /dev/null; then
    install_wm=1
fi


# Update package information
sudo apt update


# Clone repository if necessary
sudo apt install -y git

if [[ -z ${BASH_SOURCE}  ]]; then
	# We need to clone the repository
	git clone https://github.com/fab1ano/dotfiles .dotfiles
	cd .dotfiles
else
	# We assume that the repository is already cloned
	cd "$(dirname "${BASH_SOURCE}")";
fi


# Install setup dependencies
sudo apt install -y python3 python3-pip virtualenv zsh


# Install packages
sudo apt install -y curl gdb htop tmux tree vim xclip wget


# Link all configs
pushd home

# Link config files
for config_file in $(git ls-tree -r --name-only main .); do
	if [[ -f $config_file ]]; then
		mkdir -p $(dirname ~/$config_file)
		ln -sf ${PWD}/$config_file ~/$config_file
	fi
done

# Symlink submodules
git submodule status -- . | awk '{ print $2  }' | xargs -I {} sh -c "rm -rf ~/{}; ln -sf ${PWD}/{} ~/{}"

# Update submodules
git submodule update --init --recursive .

popd


# Install GEF
wget -q https://raw.githubusercontent.com/hugsy/gef/dev/gef.py -O ~/.gdbinit-gef.py


# Install Vim solarized theme
mkdir -p ~/.vim/colors
wget -q https://raw.githubusercontent.com/altercation/solarized/master/vim-colors-solarized/colors/solarized.vim -O ~/.vim/colors/solarized.vim


# Install virtualenvwrapper
pip3 install virtualenvwrapper


# Set zsh as default shell
sudo chsh -s /usr/bin/zsh $USERNAME


# Window Manager
if [[ -n "$install_wm" ]]; then
  # Install i3wm
  /usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2022.02.17_all.deb keyring.deb SHA256:52053550c4ecb4e97c48900c61b2df4ec50728249d054190e8a0925addb12fc6
  sudo dpkg -i ./keyring.deb
  echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list >/dev/null
  sudo apt update
  sudo apt install -y autorandr brightnessctl feh i3 i3lock i3status inputplug scrot terminator xdotool
  # Likely also: dunst

  # Link window manager config files
  pushd home_wm
  for config_file in $(git ls-tree -r --name-only main .); do
      if [[ -f $config_file ]]; then
          mkdir -p $(dirname ~/$config_file)
          ln -sf ${PWD}/$config_file ~/$config_file
      fi
  done
  popd

fi
