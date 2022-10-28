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
  sudo apt-get install -y rcm tmux universal-ctags ripgrep bat jq fzf fuse libfuse2 # when we get to Ubuntu 21.04 fuse will blow things up, apparently.

  fancy_echo "Installing dotfiles..."
  mv $HOME/.zshrc $HOME/.zshrc.old
  rcup -f -v -d .

  # Use RDM for copy/paste and open support
  fancy_echo "Installing RDM..."
  wget https://github.com/BlakeWilliams/remote-development-manager/releases/download/v0.0.3/rdm-linux-amd64
  sudo mv rdm-linux-amd64 /usr/local/bin/rdm
  chmod +x /usr/local/bin/rdm

  gh config set browser "rdm open"
  echo 'alias open="rdm open"' >> ~/.zshenv
  echo 'alias xdg-open="rdm open"' >> ~/.zshenv
  echo 'alias pbcopy="rdm copy"' >> ~/.zshenv

  fancy_echo "Installing neovim..."
  wget https://github.com/neovim/neovim/releases/download/v0.7.0/nvim.appimage
  chmod u+x nvim.appimage
  sudo mv nvim.appimage /usr/local/bin/nvim

  # fancy_echo "Setting up neovim..."
  # nvim --headless +PluginInstall +qall

  # Prefer zsh shell
  sudo chsh -s $(which zsh) $(whoami)

  fancy_echo "Install typescript things.."
  /workspaces/github/bin/npm install -g typescript typescript-language-server

  fancy_echo "Done."
fi
