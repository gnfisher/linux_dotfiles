if [[ `uname` == "Darwin" ]]; then
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_UPDATE=1
  export PATH="/opt/homebrew/sbin:/opt/homebrew/bin:$PATH"
fi


