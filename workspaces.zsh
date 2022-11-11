#/usr/bin/env bash
# "workspace" command.
# Written by IzikAJ <izikaj@gmail.com>.

WORKSPACES_FOLDER=~/www/_vscode_workspaces

# switch to project
workspace()
{
  local items choose

  items=$(ls $WORKSPACES_FOLDER | grep '.code-workspace' | sed -e 's:.code-workspace::')
  choose=$(echo $items | fzf --ansi)
  [ ! -z "$choose" ] && code -r "$WORKSPACES_FOLDER/$choose.code-workspace"
}

alias ws="workspace"
