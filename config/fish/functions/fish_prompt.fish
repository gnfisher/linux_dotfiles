# name: RobbyRussel (modified)
#
# You can override some default options in your config.fish:
#   set -g theme_display_git_untracked no

function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  set -l show_untracked (git config --bool bash.showUntrackedFiles)
  set -l untracked
  if [ "$theme_display_git_untracked" = 'no' -o "$show_untracked" = 'false' ]
    set untracked '--untracked-files=no'
  end
  echo (command git status -s --ignore-submodules=dirty $untracked 2> /dev/null)
end

function fish_prompt
  set -l last_status $status
  set -l yellow (set_color -o yellow)
  set -l blue (set_color -o 39BAE6)
  set -l green (set_color -o C2D94C)
  set -l red (set_color -o F07178)
  set -l normal (set_color normal)

  set -l cwd $blue(basename (prompt_pwd))

  if [ (_git_branch_name) ]
    set git_branch $green(_git_branch_name)
    set git_info " $git_branch"

    if [ (_is_git_dirty) ]
      set -l dirty "$yellow ✗"
      set git_branch $red(_git_branch_name)
      set git_info " $git_branch$dirty"
    end
  end

  echo -n -s $cwd $git_info $normal ' % '
end

