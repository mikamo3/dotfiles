#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../utils.sh"

install_package() {
  declare -r PACKAGE="$1"
  if ! package_is_installed "$PACKAGE"; then
    execute "sudo pacman -S --noconfirm $PACKAGE" "Install $PACKAGE"
  else
    print_success "$PACKAGE is already installed"
  fi
}

package_is_installed() {
  pacman -Qs "$1" &>/dev/null
}

main() {
  sudo_keepalive
  execute "sudo pacman -Syu --noconfirm" "Upgrade package"
  while read -r package; do
    install_package "$package"
  done <../../../packages/arch/pacman-package-list
}
main "$@"
