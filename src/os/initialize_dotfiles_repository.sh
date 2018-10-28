#!/bin/bash
#initialize dotfiles directory as git repository
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../utils.sh"

main() {
  local -r GITHUB_REPOSITORY=${1:-'your_github_account_name/your_repository_name'}
  local -r GITHUB_ORIGIN="git@github.com:$GITHUB_REPOSITORY.git"
  local -r BASE_DIR_GIT=$(readlink -f "$(pwd)/../../")
  print_title "Initialize dotfiles directory as git repository"

  if command -v git &>/dev/null; then
    print_info "git is installed."
  else
    print_warn "git is not installed. exiting..."
    return 1
  fi

  if (cd "$BASE_DIR_GIT" && git rev-parse) &>/dev/null; then
    print_info "$BASE_DIR_GIT is git worktree"
  else
    execute "cd $BASE_DIR_GIT && git init && git remote add $GITHUB_ORIGIN"
  fi

  print_info "Update content"
  #TODO: ask question
  ssh -T git@github.com
  if [ $? -ne 1 ]; then
    print_error "Connection failed. Please check regist a public SSH key to Github"
    return 1
  fi
  git fetch --all 1>/dev/null &&
    git reset --hard origin/master 1>/dev/null &&
    git clean -fd 1>/dev/null
  if [[ $? -ne 0 ]]; then
    print_error "Update content"
    return 1
  fi
  print_success "Update content"
  return 0
}

main "$@"
