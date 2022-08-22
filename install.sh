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

  if ! command -v nvim &> /dev/null; then
    fancy_echo "Installing neovim..."
    curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage --appimage-extract
    ./squashfs-root/AppRun --version
    sudo mkdir $HOME/.local/bin
    sudo mv squashfs-root / && sudo ln -s /squashfs-root/AppRun $HOME/.local/bin/nvim
  fi

  fancy_echo "Installing dotfiles..."
  mv $HOME/.zshrc $HOME/.zshrc.old
  rcup -f -v -d .

  # Use RDM for copy/paste and open support
  wget https://github.com/BlakeWilliams/remote-development-manager/releases/download/v0.0.3/rdm-linux-amd64
  sudo mv rdm-linux-amd64 /usr/bin/local/rdm
  chmod +x /usr/bin/local/rdm

  gh config set browser "rdm open"

  fancy_echo "Setting up neovim..."
  nvim +PluginInstall +qa

  # Default to HTTPS for GitHub access
  git config --global url.https://github.com/.insteadOf git@github.com:

  sudo chsh -s $(which zsh) $(whoami)

  fancy_echo "Done."
fi
