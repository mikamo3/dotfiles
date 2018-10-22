#!/bin/bash
declare -r GITHUB_REPOS="mikamo3/dotfiles"
declare -r DOTFILES_ORIGIN="git@github.com:$GITHUB_REPOS.git"
declare -r DOTFILES_TARBALL_URL="https://github.com/$GITHUB_REPOS/tarball/master"

declare -r DOTFILES_DIRECTORY="$HOME/.dotfiles"

download_repos() {
	printf "download dotfiles from %s\n" "$DOTFILES_TARBALL_URL"
	local tmpFile=""
	tmpFile=$(mktemp)
	download "$DOTFILES_TARBALL_URL" "$tmpFile"
	if [ -e "$DOTFILES_DIRECTORY" ]; then
		printf "%s already exists\n" "$DOTFILES_DIRECTORY"
		return 1
	fi
	mkdir -p "$DOTFILES_DIRECTORY"
	printf "exact to %s\n" "$DOTFILES_DIRECTORY"
	extract "$tmpFile" "$DOTFILES_DIRECTORY"
}

download() {
	local url="$1"
	local dstFile="$2"
	if command -v "curl" &>/dev/null; then
		curl -LsSo "$dstFile" "$url" &>/dev/null
		return $?
	elif command -v "wget" &>/dev/null; then
		wget -qO "$dstFile" "$url" &>/dev/null
		return $?
	fi
	return 1
}

extract() {
	local archive="$1"
	local outputDir="$2"

	if command -v "tar" &>/dev/null; then
		tar zxf "$archive" --strip-components 1 -C "$outputDir"
		return $?
	fi
	return 1
}

check_os() {
	printf "check os\n"
	local os
	os=$(get_os)
	if [ "$os" == "arch" ]; then
		return 0
	fi
	printf "this script is not supported %s\n" "$os"
	return 1
}

main() {
	printf "dotfiles\n"
	cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

	if [ $(pwd) == "${DOTFILES_DIRECTORY}/src" ]; then
		. "utils.sh" || exit 1
	else
		download_repos || exit 1
		cd "${DOTFILES_DIRECTORY}/src" || exit 1
		. "utils.sh" exit 1

	fi

	#install package
	check_os || exit 1

	./os/install.sh

	./os/symlink.sh

	./os/initalize_git_repository.sh
}
main "$@"
