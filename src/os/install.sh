#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../utils.sh"

main() {

	run_scripts "./common/before_install"
	run_scripts "./$(get_os)/before_install"

	./common/install.sh
	./"$(get_os)"/install.sh

	run_scripts "./common/after_install"
	run_scripts "./$(get_os)/after_install"
}
main "$@"
