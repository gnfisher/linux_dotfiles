if [[ $(uname) == "Darwin" ]]; then
  source "$(/opt/homebrew/bin/brew --prefix asdf)/libexec/asdf.sh"
elif ! [[ "$CODESPACES" = "true" ]]; then
  source "$HOME"/.asdf/asdf.sh
fi
