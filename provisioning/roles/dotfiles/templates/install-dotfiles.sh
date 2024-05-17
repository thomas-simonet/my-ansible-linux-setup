#!/bin/bash

echo "Downloading nerd-fonts..."
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip \
&& cd ~/.local/share/fonts && unzip Meslo.zip && rm *Windows* && rm Meslo.zip && fc-cache -fv

# cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz
# tar xf FiraCode.tar.xz && rm FiraCode.tar.xz && fc-cache -fv

echo "Cleaning..."
rm ${HOME}/install-dotfiles.sh

exit 0