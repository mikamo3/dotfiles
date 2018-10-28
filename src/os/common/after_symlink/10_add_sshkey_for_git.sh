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

  #when github.com profile is not. set in config file
  if ! grep -Eq "Host.*github.com" "${HOME}/.ssh/config" &>/dev/null; then
    print_info "add github.com profile to ssh config file"
    printf "%s\n" \
      "Host github.com" \
      "  HostName github.com" \
      "  IdentityFile $SSH_KEY_GITHUB_PATH" \
      "  LogLevel ERROR" >>"${HOME}/.ssh/config"
  fi

  #add public key to Github (need API key)
  local git_api_token
  local ssh_pub
  local git_ssl_keyname
  print_info "Add SSH key to Github"
  confirm "Please privide a Github Personal access token: "
  git_api_token="$REPLY"
  ssh_pub="$(tail -1 <"$SSH_KEY_GITHUB_PATH.pub")"
  git_ssl_keyname="$(hostname)_$(date +%d-%m-%Y)"

  status_code=$(curl -H "Authorization: token ${git_api_token}" \
    -H "Content-Type: application/json" \
    -X POST -d "{\"title\":\"${git_ssl_keyname}\",\"key\":\"${ssh_pub}\"}" "https://api.github.com/user/keys" \
    -o /dev/null \
    -w '%{http_code}' \
    -s)
  if [[ 201 -ne "$status_code" ]]; then
    print_error "Add SSH key to Github (statusCode:$status_code)"
    return 1
  fi
  print_success "Add SSH key to Github"
  return 0
}

main "$@"
