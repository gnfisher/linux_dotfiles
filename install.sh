#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

function fancy_echo() {
        local fmt="$1"; shift

        printf "\\n$fmt\\n" "$@"
}

if [[ "$CODESPACES" = "true" ]]; then
  fancy_echo "Installing apt packages..." 
  sudo apt-get install -y rcm tmux universal-ctags ripgrep bat jq fzf

  fancy_echo "Installing neovim..."
  curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
  chmod u+x nvim.appimage
  ./nvim.appimage --appimage-extract
  ./squashfs-root/AppRun --version
  sudo mv squashfs-root / && ln -s /squashfs-root/AppRun $HOME/.local/bin/nvim


  fancy_echo "Installing dotfiles..."
  mv $HOME/.zshrc $HOME/.zshrc.old
  rcup -f -v -d -U install.sh .

  fancy_echo "Setting up neovim..."
  nvim +PluginInstall +qa

  # Default to HTTPS for GitHub access
  git config --global url.https://github.com/.insteadOf git@github.com:

  fancy_echo "Done."
fi
