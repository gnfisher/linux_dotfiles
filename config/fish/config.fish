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

function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s%s%s@%s%s %s%s%s$ ' \
    (set_color green) $USER (set_color white) (set_color cyan) (hostname -s) \
    (set_color brwhite) (prompt_pwd) (set_color normal)
end
