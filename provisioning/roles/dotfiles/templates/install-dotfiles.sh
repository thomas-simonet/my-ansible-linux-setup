#!/bin/bash

# Set the directory we want to store zinit and plugins
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

echo "Downloading nerd-fonts..."
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz \
&& cd ~/.local/share/fonts && tar xf FiraCode.tar.xz && rm FiraCode.tar.xz && fc-cache -fv

echo "Cleaning..."
rm ${HOME}/install-dotfiles.sh

exit 0