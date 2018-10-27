#!/bin/bash
# generate sshkey for github
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../utils.sh"
main() {
  local -r SSH_KEY_GITHUB_PATH=${HOME}/.ssh/github
  local -r EMAIL="kamo3proj@gmail.com"
  print_title "Generate Github ssh key"
  if [ -e "$SSH_KEY_GITHUB_PATH" ]; then
    print_info "$SSH_KEY_GITHUB_PATH already exists."
  else
    execute "ssh-keygen -t rsa -b 4096 -C $EMAIL -f $SSH_KEY_GITHUB_PATH" "generate ssh key for Github"
  fi

  #when github.com profile is not set in config file
  if ! grep -Eq "Host.*github.com" "${HOME}/.ssh/config" &>/dev/null; then
    print_info "add github.com profile to ssh config file"
    printf "%s\n" \
      "Host github.com" \
      "  HostName github.com" \
      "  IdentityFile $SSH_KEY_GITHUB_PATH" \
      "  LogLevel ERROR" >>"${HOME}/.ssh/config"
  fi

}
main "$@"
