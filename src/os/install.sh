#!/bin/bash
# install package
# 1.run before install script

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../utils.sh"

main() {
  print_title "Install package"
  check_os || return 1

  print_title "Run before install (common)"
  run_scripts "./common/before_install"
  print_success "Run before install (common)\n"

  print_title "Run before install ($(get_os))"
  run_scripts "./$(get_os)/before_install"
  print_success "Run before install ($(get_os))\n"

  print_title "Install common"
  ./common/install.sh
  print_success "Install common\n"

  print_title "Install $(get_os)"
  ./"$(get_os)"/install.sh
  print_success "Install $(get_os)\n"

  print_title "Run after install (common)"
  run_scripts "./common/after_install"
  print_success "Run before install (common)\n"

  print_title "Run after install ($(get_os))"
  run_scripts "./$(get_os)/after_install"
  print_success "Run after install ($(get_os))\n"
}
main "$@"
