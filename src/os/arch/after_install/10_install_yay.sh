#!/bin/bash
# install yay
declare -r YAY_REPOSITORY_URL="https://aur.archlinux.org/yay.git"

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../utils.sh"
install_yay() {
  local work_dir
  work_dir=$(mktemp -d)
  git clone "$YAY_REPOSITORY_URL" "$work_dir" && cd "$work_dir" && makepkg -si
}
main() {
  print_title "Install yay"
  if ! command -v yay; then
    if ! command -v git; then
      print_error "git is not installed. Please install git"
      return 1
    fi
    execute "install_yay" "Install yay"
  else
    print_success "yay is installed"
  fi
}
main "$@"
