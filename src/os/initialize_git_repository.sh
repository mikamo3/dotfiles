#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../utils.sh"
check_git() {
	if ! command -v "git" % >/dev/null; then
		print_error "git is not installed!"
		return 1
	fi
}

check_git
