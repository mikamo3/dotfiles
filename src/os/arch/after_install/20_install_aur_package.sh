#!/bin/bash
# install aur package with yay
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../utils.sh"

install_package() {
  declare -r PACKAGE="$1"
  if ! package_is_installed "$PACKAGE"; then
    execute "yay -S --noconfirm $PACKAGE" "Install $PACKAGE"
  else
    print_success "$PACKAGE is already installed"
  fi
}

main() {
  local package_list
  sudo_keepalive
  if ! command -v yay; then
    print_error "yay is not installed"
    return 1
  fi
  package_list=$(tr "\n" " " <../../../../packages/arch/aur-package-list)
  execute "yay -S $package_list" "Install AUR package"
  while read -r package; do
    install_package "$package"
  done <../../../../packages/arch/aur-package-list
}
main "$@"
