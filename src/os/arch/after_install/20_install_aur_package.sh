#!/bin/bash
# install aur package with yay
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../utils.sh"

install_package() {
  declare -r PACKAGE="$1"
  if ! package_is_installed "$PACKAGE"; then
    execute "yay -S $PACKAGE" "Install $PACKAGE"
  else
    print_success "$PACKAGE is already installed"
  fi
}
is_installed() {
  local query=$1
  pacman -Q "$query" &>/dev/null
}

concat_package_list() {
  local package_list_file=$1
  local output_list=""
  while read -r item; do
    item=$(printf "%s" "$item" | sed 's/#.*//g')
    if [[ "${item//[ ]/}" == "" ]]; then
      continue
    fi
    if ! is_installed "$item"; then
      output_list+=$(printf "%s" " $item")
    fi
  done <"$package_list_file"
  printf "%s" "$output_list"
}
main() {
  print_title "Install AUR packages with yay"
  local package_list
  if ! command -v yay &>/dev/null; then
    print_error "yay is not installed"
    return 1
  fi

  package_list=$(concat_package_list "../../../../packages/arch/aur-package-list")
  [[ "${package_list//[ ]/}" == "" ]] && print_success "There is no AUR package to install " && return 0
  execute "yay -S $package_list" "Install AUR packages"
}
main "$@"
