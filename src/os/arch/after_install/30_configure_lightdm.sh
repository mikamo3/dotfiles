#!/bin/bash
# configure_lightdm
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../utils.sh"
main() {
  execute "sudo cp -u ../../../../etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf" "$(readlink -f ../../../../etc/lightdm/lightdm.conf) → /etc/lightdm/lightdm.conf"
  execute "sudo systemctl enable lightdm"
}

main "$@"
