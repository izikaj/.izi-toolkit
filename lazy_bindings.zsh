#/usr/bin/env bash

# add node-loading alias for bundle command
bundle() {
  unset -f bundle
  _zsh_nvm_load
  bundle $@
}
