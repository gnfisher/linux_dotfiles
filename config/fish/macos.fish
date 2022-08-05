set HOMEBREW_NO_AUTO_UPDATE 1
set JAVA_HOME (/usr/libexec/java_home -v 1.8)
set HOMEBREW_DIR /opt/homebrew

fish_add_path $HOMEBREW_DIR/sbin \
  $HOMEBREW_DIR/bin \
  $HOME/Library/Application\ Support/Coursier/bin

source (brew --prefix asdf)/libexec/asdf.fish
