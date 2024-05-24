#!/bin/bash

DOCKER_COMPLETIONS="${HOME}/.cache/zinit/completions/_docker"

# Download docker completions, if it's not there
if [ ! -f "${DOCKER_COMPLETIONS}" ]; then
  mkdir -p "$(dirname $DOCKER_COMPLETIONS)"
  wget -P "$(dirname $DOCKER_COMPLETIONS)" https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker
fi

echo "Downloading nerd-fonts..."
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz \
&& cd ~/.local/share/fonts && tar xf FiraCode.tar.xz && rm FiraCode.tar.xz && fc-cache -fv

echo "Cleaning..."
rm ${HOME}/install-dotfiles.sh

exit 0