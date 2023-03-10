# Add binstubs to path
export PATH=".git/safe/../../bin:$PATH"

# Add dotfiles bin
export PATH="$HOME/.bin:$PATH"

# Add Coursier
export PATH="$PATH:/Users/greg/Library/Application Support/Coursier/bin"

# Add GOPATH
export GOPATH=$HOME/go
export PATH="$PATH:$HOME/go/bin"

# Load autocomplete
autoload -U compinit
compinit

# makes color constant available
autoload -U colors
colors

export CLICOLOR=1             # enable colored output from ls, etc. on FreeBSD-based systems

# Show ls on dark backgrounds well
unset LSCOLORS
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS=$LSCOLORS

# Grep gets colors too
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;32'

# HISTORY!
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.history

unsetopt BANG_HIST            # This allows usage of ! without escaping, eg: `git commit -m "yes!"`
unsetopt nomatch              # Allow [ or ] whereever you want
setopt extendedglob           # Enable extended globbing
setopt append_history         # Append, not replace
setopt inc_append_history     # Immediately append history
setopt always_to_end          # Always go to end of line on complete
setopt correct                # Correct typos
setopt hist_ignore_dups       # Do not show dupes in history
setopt hist_ignore_space      # Ignore commands starting with space
setopt prompt_subst           # Necessary for pretty prompts

# awesome cd movements from zshkit (via thoughtbot dotfiles)
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

stty -ixon

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey "^Q" push-line-or-edit
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# Load all files in ~/.zsh
for function in ~/.zsh/*.zsh; do
  source $function
done

# aliases
[[ -f ~/.aliasrc ]] && source ~/.aliasrc

# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  current_branch=$(git current-branch 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo " %{$fg_bold[green]%}$current_branch%{$reset_color%}"
  fi
}

# Allow exported PS1 variable to override default prompt.
if ! env | grep -q '^PS1='; then
  PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) %# '
fi

# Export editor preference
export EDITOR=nvim
export VISUAL=nvim

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  export EDITOR=nvim
  export VISUAL="code --wait"
fi

export GPG_TTY=$(tty)
