set -U fish_greeting
set TERM "xterm-256color"
set EDITOR nvim
set JAVA_HOME "/usr/bin/java"

set PATH /home/greg/.cargo/bin $PATH
set PATH $PATH "$PATH:/home/greg/.bin:/usr/local/bin"
set PATH /home/greg/.asdf/installs/nodejs/15.13.0/.npm/bin $PATH
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

function fish_prompt -d "Write out the prompt"
    set -g $__fish_git_prompt_showcolorhints true
    printf '%s%s%s:%s%s%s%s%s $ ' \
    (set_color -o blue) $USER (set_color normal) (set_color green) (basename $PWD) (set_color red) (fish_git_prompt) (set_color normal)
end
