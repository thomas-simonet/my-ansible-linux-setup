#!/bin/bash

echo "Downloading nerd-fonts..."
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz \
&& cd ~/.local/share/fonts && tar xf FiraCode.tar.xz && rm FiraCode.tar.xz && fc-cache -fv

echo "Cleaning..."
rm ${HOME}/install-dotfiles.sh

exit 0