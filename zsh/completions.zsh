# Load completion functions
if [[ `uname` == "Darwin" ]]; then
  fpath=(/opt/homebrew/share/zsh-completions:$fpath)
else
  fpath=(/usr/local/share/zsh/site-functions $fpath)
fi
