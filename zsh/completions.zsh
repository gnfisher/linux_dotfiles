# Load completion functions
if [[ `uname` == "Darwin" ]]; then
  fpath=$(brew --prefix)/share/zsh-completions:$fpath
else
  fpath=(/usr/local/share/zsh/site-functions $fpath)
fi
