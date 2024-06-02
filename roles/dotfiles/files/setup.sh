#!/bin/bash

DOCKER_COMPLETIONS="${HOME}/.cache/zinit/completions/_docker"
EZA_COMPLETIONS="${HOME}/.cache/zinit/completions/eza"


# ------------------------------------
# Download docker completions, if it's not there
# ------------------------------------
if [ ! -f "${DOCKER_COMPLETIONS}" ]; then
  mkdir -p "$(dirname $DOCKER_COMPLETIONS)"
  wget -P "$(dirname $DOCKER_COMPLETIONS)" https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker
fi


# ------------------------------------
# Install nerd fonts
# ------------------------------------
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz \
&& cd ~/.local/share/fonts && tar xf FiraCode.tar.xz && rm FiraCode.tar.xz && fc-cache -fv


# ------------------------------------
# Install eza
# ------------------------------------
if [ ! -d "/etc/apt/keyrings" ]; then
  mkdir -p /etc/apt/keyrings
fi

if [ ! -d "${EZA_COMPLETIONS}" ]; then
  cd "$(dirname $EZA_COMPLETIONS)" && mkdir -p "eza"
  cd "$EZA_COMPLETIONS" && git clone https://github.com/eza-community/eza.git .
fi

if [ ! -f "/etc/apt/keyrings/gierens.gpg" ]; then
  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
fi

echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt-get update
sudo apt-get install -y eza
# /end eza


# ------------------------------------
# Install just
# ------------------------------------
if [ ! -d "~/bin" ]; then
  mkdir -p ~/bin
fi

curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | sh -s -- --to ~/bin
# /end just


# ------------------------------------
# Install Atuin
# ------------------------------------
bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)


# ------------------------------------
# Delete this script
# ------------------------------------
rm ${HOME}/setup.sh

exit 0