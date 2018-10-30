#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../utils.sh"

main() {
  local package_list
  package_list=$(tr "\n" " " <../../../packages/arch/pacman-package-list)
  sudo_keepalive

  execute "sudo pacman -Syu" "Upgrade package"
  execute "sudo pacman -S $package_list"
}
main "$@"
