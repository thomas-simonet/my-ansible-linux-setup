curl -o ${HOME}/install-starship.sh https://starship.rs/install.sh
# yes | ${HOME}/install-starship.sh

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz
tar xf FiraCode.tar.xz && rm FiraCode.tar.xz