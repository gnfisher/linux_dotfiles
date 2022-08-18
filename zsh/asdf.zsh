if [[ `uname` == "Darwin" ]]; then
  source "$(brew --prefix asdf)/libexec/asdf.sh"
else
  source $HOME/.asdf/asdf.sh
fi
