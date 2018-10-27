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
    return 0
  fi

  (cd "$BASE_DIR_GIT" && git init && git remote add "$GITHUB_ORIGIN")

}

main "$@"
