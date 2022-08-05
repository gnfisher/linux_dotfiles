set JAVA_HOME "/usr/bin/java"

source ~/.asdf/asdf.fish

# Colorize ls output
function ls
  command ls --color=auto $argv
end

