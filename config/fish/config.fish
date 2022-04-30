set -U fish_greeting
set TERM "xterm-256color"
set EDITOR vim

switch (uname)
    case Linux
      set JAVA_HOME "/usr/bin/java"
      source ~/.config/fish/linux.fish
      source ~/.asdf/asdf.fish
    case Darwin
      set HOMEBREW_NO_AUTO_UPDATE 1

      switch (hostname)
        case igloo.local
          set PATH /opt/homebrew/bin $PATH
          set paTH /opt/homebrew/sbin $PATH
          set JAVA_HOME (/usr/libexec/java_home -v 1.8)
          source (brew --prefix asdf)/libexec/asdf.fish
          # Todo: make config special for M1 mac
        case '*'
          source ~/.config/fish/hubble.fish
      end
end

set PATH $HOME/Library/Application\ Support/Coursier/bin $PATH
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH
set PATH $PATH "$PATH:$HOME/.bin:/usr/local/bin"
set PATH $HOME/.local/share/idea/bin $PATH
set PATH $HOME/.local/share/lua-language-server/bin $PATH

source ~/.aliasrc

function mcd
  command mkdir $argv[1] && cd $argv[1]
end

# Ensure tmux is running
# if not set -q TMUX
#   command tat
# end
# status --is-interactive; and source (jenv init -|psub)
