IZI_TOOLKIT_ROOT=${IZI_TOOLKIT_ROOT:="$HOME/.izi-toolkit"}

[ -f "$IZI_TOOLKIT_ROOT/jump.zsh" ] && source "$IZI_TOOLKIT_ROOT/jump.zsh"
[ -f "$IZI_TOOLKIT_ROOT/publish_gem_fury_io.zsh" ] && source "$IZI_TOOLKIT_ROOT/publish_gem_fury_io.zsh"
[ -f "$IZI_TOOLKIT_ROOT/workspaces.zsh" ] && source "$IZI_TOOLKIT_ROOT/workspaces.zsh"
[ -f "$IZI_TOOLKIT_ROOT/lazy_bindings.zsh" ] && source "$IZI_TOOLKIT_ROOT/lazy_bindings.zsh"
[ -f "$IZI_TOOLKIT_ROOT/merge.zsh" ] && source "$IZI_TOOLKIT_ROOT/merge.zsh"

export PATH="$IZI_TOOLKIT_ROOT/process:$PATH"
