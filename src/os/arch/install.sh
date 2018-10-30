#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../utils.sh"

main() {
  print_title "Install packages with pacman"
  local package_list
  package_list=$(tr "\n" " " <../../../packages/arch/pacman-package-list)
  sudo_keepalive

  execute "sudo pacman -Syu" "Upgrade packages"
  execute "sudo pacman -S $package_list" "Install packages"
}
main "$@"
