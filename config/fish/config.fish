set -U fish_greeting
set TERM "xterm-256color"
set EDITOR nvim
set JAVA_HOME "/usr/bin/java"

set PATH $PATH "$PATH:/home/greg/.bin:/usr/local/bin"
set PATH /home/greg/.asdf/installs/nodejs/15.11.0/.npm/bin $PATH
set PATH /home/greg/.local/share/coursier/bin $PATH

source ~/.asdf/asdf.fish

source ~/.aliasrc

# Colorize ls output
function ls
  command ls --color=auto $argv
end

function mcd
  command mkdir $argv[1] && cd $argv[1]
end
