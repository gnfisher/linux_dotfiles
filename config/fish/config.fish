set -U fish_greeting
set TERM "xterm-256color"
set EDITOR nvim
set JAVA_HOME "/usr/bin/java"

set PATH $PATH "$PATH:/home/greg/.bin"
set PATH /home/greg/.asdf/installs/nodejs/15.11.0/.npm/bin $PATH
set PATH /home/greg/.local/share/coursier/bin $PATH

source ~/.asdf/asdf.fish

source ~/.aliasrc
