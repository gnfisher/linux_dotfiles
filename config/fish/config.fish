set -U fish_greeting

set TERM "xterm-256color"
set EDITOR nvim

set -U fish_pager_color_selected_background --background=124476

fish_add_path $HOME/.cargo/bin \
  $HOME/.local/bin \
  $HOME/.bin /usr/local/bin \
  $HOME/.local/share/lua-language-server/bin

switch (uname)
    case Linux
      source $HOME/.config/fish/linux.fish
    case Darwin
      source $HOME/.config/fish/macos.fish
end


source ~/.aliasrc

# Ensure tmux is running
if not set -q TMUX
  command tat
end
