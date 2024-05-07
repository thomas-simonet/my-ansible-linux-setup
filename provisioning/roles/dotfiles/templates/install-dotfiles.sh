#!/bin/bash

echo "Installing ohmyzsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing starship..."
curl -o ${HOME}/install-starship.sh https://starship.rs/install.sh && chmod 0755 ${HOME}/install-starship.sh
sh ${HOME}/install-starship.sh

echo "Cloning zsh plugins..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use

echo "Downloading nerd-fonts..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz
tar xf FiraCode.tar.xz && rm FiraCode.tar.xz

echo "Cleaning..."
rm ${HOME}/install-dotfiles.sh
rm ${HOME}/install-starship.sh

exit 0