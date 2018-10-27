#!/bin/bash
# install package
# 1.run before install script

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../utils.sh"

main() {
  print_title "Install \n\n"
  check_os || return 1

  print_title "Run before install (common)\n"
  run_scripts "./common/before_install"
  print_info "Run before install (common) complete\n"

  print_title "Run before install ($(get_os))\n"
  run_scripts "./$(get_os)/before_install"
  print_info "Run before install ($(get_os)) complete\n"

  print_title "Install common...\n"
  ./common/install.sh
  print_info "Install common complete\n"

  print_title "Install $(get_os)...\n"
  ./"$(get_os)"/install.sh
  print_info "Install $(get_os) complete\n"

  print_title "Run after install (common)\n"
  run_scripts "./common/after_install"
  print_info "Run before install (common)\n"

  print_title "Run after install ($(get_os))\n"
  run_scripts "./$(get_os)/after_install"
  print_info "Run after install ($(get_os)) complete\n"
}
main "$@"
