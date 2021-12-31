set -U fish_greeting
set TERM "xterm-256color"
set EDITOR nvim
set JAVA_HOME "/usr/bin/java"

set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH
set PATH $PATH "$PATH:$HOME/.bin:/usr/local/bin"
set PATH $HOME/.asdf/installs/nodejs/15.13.0/.npm/bin $PATH
set PATH $HOME/.local/share/coursier/bin $PATH

source ~/.asdf/asdf.fish

source ~/.aliasrc

# Colorize ls output
function ls
  command ls --color=auto $argv
end

function mcd
  command mkdir $argv[1] && cd $argv[1]
end

# Ensure tmux is running
if not set -q TMUX
  command tat
end
