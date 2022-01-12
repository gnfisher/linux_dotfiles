set -U fish_greeting
set TERM "xterm-256color"
set EDITOR nvim

switch (uname)
    case Linux
      set JAVA_HOME "/usr/bin/java"
      source ~/.config/fish/linux.fish
    case Darwin
      set HOMEBREW_NO_AUTO_UPDATE 1
end

set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH
set PATH $PATH "$PATH:$HOME/.bin:/usr/local/bin"
set PATH $HOME/.local/share/coursier/bin $PATH
set PATH $HOME/.local/share/idea/bin $PATH


source ~/.asdf/asdf.fish
source ~/.aliasrc

function mcd
  command mkdir $argv[1] && cd $argv[1]
end

# Ensure tmux is running
if not set -q TMUX
  command tat
end
