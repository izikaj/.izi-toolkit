#/usr/bin/env bash
# The "jump" command.
# Written by IzikAJ <izikaj@gmail.com>.

# used for quick jump between projects
# manual index start: __find_and_cache_projects
# usage: j - Enter - Type name - Enter
# requirements: fzf

JUMP_PROJECTS_ROOT=~/www
JUMP_PROJECTS_CONFIG_PATH=$JUMP_PROJECTS_ROOT/.config

__find_and_cache_projects()
{
  local lockfile lpid
  lockfile="$JUMP_PROJECTS_CONFIG_PATH/.list.txt.lock"
  if [ -f "$lockfile" ]; then
    echo "LOCKED by file: $lockfile"
    lpid="$(cat "$lockfile")"
    if [ -z "$lpid" ] || [ -z "$(ps -p "$lpid" | grep "$lpid")" ] ; then
      echo "But no process found"
      rm "$lockfile"
    else
      return 0
    fi
  fi
  echo "$$" > $lockfile

  local f_bold f_dim f_normal c_yellow c_green

  f_normal="\e[0m"
  f_bold="\e[1m"
  f_dim="\e[2m"
  c_yellow="\e[33m"
  c_green="\e[32m"

  mkdir -p $JUMP_PROJECTS_CONFIG_PATH
  touch $JUMP_PROJECTS_CONFIG_PATH/.list.txt

  local items item name folder data chosen root
  items=$(find $JUMP_PROJECTS_ROOT -type d -maxdepth 4 -name .git | sed -e "s/\.git//" | sed -e "s:/$::")
  root=$(echo "$JUMP_PROJECTS_ROOT" | sed -e "s:/$::")

  rm $JUMP_PROJECTS_CONFIG_PATH/.list.txt
  for item in $(echo $items)
  do
    name=${item##*/}
    folder=$(echo $item | sed -e "s/$name//" | sed -e "s:/$::" | sed -e "s:$JUMP_PROJECTS_ROOT::" | sed -e "s:^/::" )
    iitem="$f_normal$f_dim$root$f_normal/$f_normal$f_dim$c_yellow$folder$f_normal/$f_bold$c_green$name$f_normal"
    echo $iitem | sed -e "s:\ ::" >> $JUMP_PROJECTS_CONFIG_PATH/.list.txt
  done

  # echo "$data" > $JUMP_PROJECTS_CONFIG_PATH/.list.txt
  rm "$lockfile"
}

# jump to project
jump()
{
  local items choose
  [ -f $JUMP_PROJECTS_CONFIG_PATH/.list.txt ] || __find_and_cache_projects

  items=$(cat $JUMP_PROJECTS_CONFIG_PATH/.list.txt)
  choose=$(echo $items | fzf --ansi)
  cd "$choose"
}

if [ -f "$JUMP_PROJECTS_CONFIG_PATH/.list.txt" ]; then
  # remove 1 day old list
  find "$JUMP_PROJECTS_CONFIG_PATH/.list.txt" -type f -mtime +1 -exec rm {} \; 2>/dev/null
fi
# create new list if not found
[ ! -f "$JUMP_PROJECTS_CONFIG_PATH/.list.txt" ] && __find_and_cache_projects
alias j="jump"
