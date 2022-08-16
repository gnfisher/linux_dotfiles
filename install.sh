#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x


if [[ "$CODESPACES" = "true" ]]; then
  sudo apt-get install -y rcm tmux universal-ctags rip-grep bat jq fzf fish
  rcup -f -v -d .
  nvim +PluginInstall +qa

  # Default to HTTPS for GitHub access
  git config --global url.https://github.com/.insteadOf git@github.com:

  sudo chsh -s $(which fish) $(whoami)
fi
