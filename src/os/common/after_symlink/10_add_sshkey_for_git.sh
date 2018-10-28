#!/bin/bash
# generate sshkey for github
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../utils.sh"
main() {
  local ssh_key_github_path="${HOME}/.ssh/github"
  local email

  print_title "Generate Github ssh key"
  ask_for_confirmation "Generate ssh key for Github? ssh key will generate to '$ssh_key_github_path'"
  if answer_is_yes; then
    if [[ -e "$ssh_key_github_path" ]]; then
      print_info "$ssh_key_github_path already exists. generate is skipped"
    else
      while [[ "$email" == "" ]]; do
        confirm "Please provide an Email"
        email=$REPLY
      done
      execute "ssh-keygen -t rsa -b 4096 -C $email -f $ssh_key_github_path" "generate ssh key for Github" || return 1
    fi
  fi

  print_title "Set ssh config for connect to github.com"
  ask_for_confirmation "Set ssh config for connect to github.com to '${HOME}/.ssh/config' ?"
  if answer_is_yes; then
    #when github.com profile is not. set in config file
    if ! grep -Eq "Host.*github.com" "${HOME}/.ssh/config" &>/dev/null; then
      printf "%s\n" \
        "Host github.com" \
        "  HostName github.com" \
        "  IdentityFile $ssh_key_github_path" \
        "  LogLevel ERROR" >>"${HOME}/.ssh/config"
      print_result "$?" "add github.com profile to '${HOME}/.ssh/config'"
    else
      print_info "The connection setting to github has already been done"
    fi
  fi

  print_title "Add SSH key to Github"
  ask_for_confirmation "Regist public key to github (It is necessary to set the API key correctly in advance) ?"
  if answer_is_yes; then

    #add public key to Github (need API key)
    local git_api_token
    local ssh_pub
    local git_ssl_keyname
    git_ssl_keyname="$(hostname)_$(date +%d-%m-%Y)"

    while [[ "$git_api_token" == "" ]]; do
      confirm "Please privide a Github Personal access token"
      git_api_token="$REPLY"
    done

    confirm "Please privide A descriptive name for the new key (default:$git_ssl_keyname)"
    [[ "$REPLY" != "" ]] && git_ssl_keyname="$REPLY"

    ssh_pub="$(tail -1 <"$ssh_key_github_path.pub")"

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
  fi
}

main "$@"
