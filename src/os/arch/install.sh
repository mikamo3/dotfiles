#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../utils.sh"

install_package() {
	declare -r EXTRA_ARGUMENTS="$3"
	declare -r PACKAGE="$2"
	declare -r PACKAGE_READABLE_NAME="$1"

	if ! package_is_installed "$PACKAGE"; then
		execute "pacman -S --noconfirm $EXTRA_ARGUMENTS $PACKAGE" "$PACKAGE_READABLE_NAME"
	else
		print_success "$PACKAGE_READABLE_NAME"
	fi
}

package_is_installed() {
	pacman -Qs "$1" &>/dev/null
}

update() {
	execute "sudo pacman -Syu --noconfirm" "pacman (pacman update)"
}

print_in_purple "Install...\n\n"
ask_for_sudo
update
for package in $(cat ../../../packages/arch/pacman-package-list); do
	install_package "$package (pacman install)" "$package"
done
