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

package_is_installed() {
  yay -Qe "$1" &>/dev/null
}

main() {
  sudo_keepalive
  if ! command -v yay; then
    print_error "yay is not installed"
    return 1
  fi
  while read -r package; do
    install_package "$package"
  done <../../../../packages/arch/aur-package-list
}
main "$@"
