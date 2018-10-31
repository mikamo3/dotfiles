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

main() {
  print_title "Install AUR packages with yay"
  local package_list
  if ! command -v yay &>/dev/null; then
    print_error "yay is not installed"
    return 1
  fi

  package_list=$(tr "\n" " " <../../../../packages/arch/aur-package-list)
  execute "yay -S $package_list" "Install AUR packages"
  while read -r package; do
    install_package "$package"
  done <../../../../packages/arch/aur-package-list
}
main "$@"
