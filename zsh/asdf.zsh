if [[ `uname` == "Darwin" ]]; then
  source "$(/opt/homebrew/bin/brew --prefix asdf)/libexec/asdf.sh"
else
  source $HOME/.asdf/asdf.sh
fi
