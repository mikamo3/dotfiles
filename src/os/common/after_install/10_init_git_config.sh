#!/bin/bash
# initialize git config
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../utils.sh"
main() {
  local -r GIT_USER_NAME="mikamo3"
  local -r GIT_EMAIL="kamo3proj@gmail.com"
  local -r GIT_EDITOR="vim"

  print_title "Initialize git config"
  execute "git config --global user.name $GIT_USER_NAME"
  execute "git config --global user.email $GIT_EMAIL"
  execute "git config --global core.editor $GIT_EDITOR"
  print_info "Initialize git config complete"
}
main "$@"
