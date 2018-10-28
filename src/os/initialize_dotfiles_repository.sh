#!/bin/bash
#initialize dotfiles directory as git repository
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../utils.sh"

main() {
  local -r BASE_DIR_GIT=$(readlink -f "$(pwd)/../../")

  print_title "Initialize git repository"
  if ! command -v git &>/dev/null; then
    print_error "git is not installed. If you want to manage the dotfile in github. Please install git,\
Adding a SSH key to your GitHub account,and run '$(readlink -f "${BASH_SOURCE[0]}")'. exiting..."
    return 1
  fi

  print_title "Initialize dotfiles directory as git repository"
  ask_for_confirmation "Would you like to manage dotfiles with git?"
  if answer_is_yes; then
    if (cd "$BASE_DIR_GIT" && git rev-parse) &>/dev/null; then
      print_info "$BASE_DIR_GIT is already managed with git"
    else
      execute "cd $BASE_DIR_GIT && git init" "Initialize dotfiles directory as git repository"
    fi
  fi

  print_title "Setting up the remote repository"
  ask_for_confirmation "Do you want to configure the dotfiles remote repository?"
  if answer_is_yes; then
    local github_account_name
    local github_repository_name
    local github_origin

    while [[ "$github_account_name" == "" ]]; do
      confirm "Please provide your github account name"
      github_account_name="$REPLY"
    done

    while [[ "$github_repository_name" == "" ]]; do
      confirm "Please provide your dotfiles repository name"
      github_repository_name="$REPLY"
    done
    github_origin="git@github.com:${github_account_name}/${github_repository_name/.git/}.git"
    print_info "  remote_origin:$github_origin"
    if [[ $(cd "$BASE_DIR_GIT" && git config --get remote.origin.url) == "$github_origin" ]]; then
      print_info "remote repository already set up. skipped"
    else
      execute "cd $BASE_DIR_GIT && git add remote origin $github_origin" "add remote origin"
    fi
  fi

  ask_for_confirmation "Update contents from Github repository?"
  if answer_is_yes; then
    ssh -T git@github.com
    if [ $? -ne 1 ]; then
      print_error "Connection failed. Please check regist a public SSH key to Github"
      return 1
    fi
    git fetch --all 1>/dev/null &&
      git reset --hard origin/master 1>/dev/null &&
      git clean -fd 1>/dev/null
    print_result $? "Update contents"
  fi
}

main "$@"
