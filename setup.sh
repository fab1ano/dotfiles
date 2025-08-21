#!/usr/bin/env bash

# Exit on error
set -e

# Show help
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Usage: setup.sh [OPTIONS] [custom_home]"
  echo ""
  echo "Options:"
  echo "  -h, --help      Show this help message"
  echo "  --link-only     Only link config files, skip installations"
  echo "  custom_home     Custom home directory path"
  echo ""
  echo "This script sets up dotfiles and installs development tools."
  exit 0
fi

# Check for link-only mode
if [[ "$1" == "--link-only" ]]; then
  link_only=1
  shift
fi

# Usage: setup.sh [custom_home]
if [[ $# -eq 1 && -d $1 ]]; then
  custom_home=1
  export HOME=$(realpath $1)
fi


# Check if X-Server is running
if command -v xset &> /dev/null && xset q &> /dev/null; then
    install_wm=1
fi


function link_configs_helper() {
  for config_file in $(git ls-tree -r --name-only main .); do
    if [[ -f $config_file ]]; then
      mkdir -p $(dirname ~/$config_file)
      ln -sf ${PWD}/$config_file ~/$config_file
    fi
  done
}

function link_all_configs() {
  # Link home configs
  pushd home
  link_configs_helper
  # Symlink submodules
  git submodule status -- . | awk '{ print $2 }' | xargs -I {} sh -c "rm -rf ~/{}; ln -sf ${PWD}/{} ~/{}"
  # Update submodules
  git submodule update --init --recursive .
  popd

  # Link window manager configs if X-Server is running
  if [[ -n "$install_wm" && -d "home_wm" ]]; then
    pushd home_wm
    link_configs_helper
    popd
  fi
}


# Handle link-only mode
if [[ -n "$link_only" ]]; then
  link_all_configs
  echo "Config files linked successfully."
  exit 0
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
sudo apt install -y curl gdb htop neovim tmux tree vim virtualenvwrapper wget xclip tig


# Link all configs
link_all_configs


# Install GEF
wget -q https://raw.githubusercontent.com/hugsy/gef/main/gef.py -O ~/.gdbinit-gef.py


# Install Vim solarized theme
mkdir -p ~/.vim/colors
wget -q https://raw.githubusercontent.com/altercation/solarized/master/vim-colors-solarized/colors/solarized.vim -O ~/.vim/colors/solarized.vim


# Set zsh as default shell or provide an entry script
if [ -z ${custom_home} ]; then
  sudo chsh -s /usr/bin/zsh $USER
else
  echo -e "#!/bin/sh\nexport HOME=${HOME}\nexec /usr/bin/zsh" > ${HOME}/activate.sh
  chmod +x ${HOME}/activate.sh
fi


# Window Manager
if [[ -n "$install_wm" ]]; then
  # If on Ubuntu, add the i3 repository (check lsb_release)
  if [[ $(lsb_release -is) == "Ubuntu" ]]; then
    /usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
    sudo apt install ./keyring.deb
    rm ./keyring.deb
    echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
  fi

  sudo apt update
  sudo apt install -y arc-theme autorandr blueman brightnessctl dunst feh fonts-font-awesome i3 i3lock i3status inputplug pasystray pipx redshift scrot terminator vim-gtk3 xdotool
  pipx install keepmenu

  # Update redshift apparmor rules to allow reading the config file
  if ! grep -q "${PWD}/home_wm/.config/redshift.conf r," /etc/apparmor.d/local/usr.bin.redshift; then
    echo "${PWD}/home_wm/.config/redshift.conf r," | sudo tee -a /etc/apparmor.d/local/usr.bin.redshift
    sudo systemctl restart apparmor
  fi

  echo "Remember to set the theme and font with 'lxappearance' (Arc and System San Francisco Display)."
  echo "And if on Debian, you want to get i3 from Debian testing."
fi
