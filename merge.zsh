#/usr/bin/env bash
# The "merge" command.
# Written by IzikAJ <izikaj@gmail.com>.

# used for quick easily merge bitbucket repos
# usage: merge staging master site_clone
# requirements: git@github.com:izikaj/batch-merge-operations.git

BITBUCKET_MERGER_ROOT="$HOME/www/sparse/staging-to-master"

merge()
{
  TARGET="$PWD"
  cd "$BITBUCKET_MERGER_ROOT"
  bundle exec ruby src/merge_one.rb $TARGET $@
  cd "$TARGET"
}
