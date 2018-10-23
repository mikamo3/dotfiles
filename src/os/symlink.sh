#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../utils.sh"

create_symlink() {
	local sourceDir=$1
	local targetDir=$2
	local sourceAbsoluteDir=""
	local targetAbsoluteDir=""
	targetAbsoluteDir=$(readlink -f "$targetDir")
	if [ ! -d "$sourceDir" ]; then
		print_error "$sourceDir - a file with the same name already exists!"
		return 1
	else
		sourceAbsoluteDir=$(readlink -f "$sourceDir")
	fi

	if [ ! -d "$targetDir" ]; then
		print_error "$targetDir - directory does not exists!"
		return 1
	fi

	while IFS= read -r -d '' symlink; do
		local symlinkAbsolutePath=""
		symlinkAbsolutePath=$(readlink -f "$symlink")
		local targetAbsolutePath="${targetAbsoluteDir}${symlinkAbsolutePath/${sourceAbsoluteDir}/}"
		#create directory
		if [ -d "$symlinkAbsolutePath" ]; then
			mkd "$targetAbsolutePath"
			continue
		fi

		if [ ! -e "$targetAbsolutePath" ]; then
			execute "ln -fs $symlinkAbsolutePath $targetAbsolutePath" \
				"$symlinkAbsolutePath → $targetAbsolutePath"
		elif [ "$(readlink "$targetAbsolutePath")" == "$symlinkAbsolutePath" ]; then
			print_success "$symlinkAbsolutePath → $targetAbsolutePath"
		else
			#when target file is real file
			ask_for_confirmation "'$targetAbsolutePath' already exists. do you want to overwrite?"
			if answer_is_yes; then
				rm -rf "$targetAbsolutePath"
				execute "ln -fs $symlinkAbsolutePath $targetAbsolutePath" \
					"$symlinkAbsolutePath → $targetAbsolutePath"
			else
				print_error "$symlinkAbsolutePath → $targetAbsolutePath"
			fi
		fi

	done < <(find "$sourceDir" -print0)
}

run_scripts "./common/before_symlink"
run_scripts "./$(get_os)/before_symlink"

print_in_purple "Create Symbolic Link (common)...\n\n"
create_symlink "../dots/common" "$HOME"
print_in_purple "Create Symbolic Link ($(get_os))...\n\n"
create_symlink "../dots/$(get_os)" "$HOME"

run_scripts "./common/after_symlink"
run_scripts "./$(get_os)/after_symlink"
