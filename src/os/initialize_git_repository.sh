#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../utils.sh"

is_git_repository() {
	git rev-parse &>/dev/null
}

check_git() {
	if ! command -v "git" % >/dev/null; then
		print_error "git is not installed!"
		return 1
	fi
}

initialize_git_repository() {
	declare -r GIT_ORIGIN=$1
	if [ -z "$GIT_ORIGIN" ]; then
		print_error "Please provide a URL for the Git origin"
		exit 1
	fi

	if ! is_git_repository; then
		cd ../../ || print_error "Failed to 'cd ../../'"
		execute \
			"git init && git remote add origin $GIT_ORIGIN" \
			"Initialize the Git repository"
	fi
}

generate_ssh_keys() {
	print_in_purple "Generate SSH Keys\n"
	ask "Please provide an email address: " && printf "\n"
	ssh-keygen -t rsa -b 4096 -C "$(get_answer)" -f "$1"
	print_result $? "Generate SSH keys"

	printf "%s\n" \
		"Host github.com" \
		"  IdentityFile $1" \
		"  LogLevel ERROR" >>"${HOME}/.ssh/config"
	print_result $? "Add SSH configs"
}

add_public_key_to_github() {
	print_in_purple "Add SSH key to Github\n"
	ask "Please provide a Personal access token: " && printf "\n"
	local gitApiToken
	gitApiToken=$(get_answer)
	local sslpub
	sslpub="$(tail -1 <"$1")"
	local gitSslKeyname
	gitSslKeyname="$(hostname)_$(date +%d-%m-%Y)"

	curl -H "Authorization: token ${gitApiToken}" \
		-H "Content-Type: application/json" \
		-X POST -d "{\"title\":\"${gitSslKeyname}\",\"key\":\"${sslpub}\"}" "https://api.github.com/user/keys" &>/dev/null
	print_result $? "Add SSH key to Github"

}

check_connect_to_git() {
	print_in_purple "Check connect to Git"
	ssh -T git@github.com &>/dev/null
	if [ $? -ne 1 ]; then
		return 1
	fi
	return 0
}

print_in_purple "Initialize Git repository\n\n"
check_git || exit 1
initialize_git_repository "$1"
if ! check_connect_to_git; then
	ask_for_confirmation "do you generate ssh key? (for github)"
	if answer_is_yes; then
		sshKeyFileName="$HOME/.ssh/github"
		if [ -f "$sshKeyFileName" ]; then
			sshKeyFileName="$(mktemp -u "$HOME/.ssh/github_XXXXX")"
		fi
		generate_ssh_keys "$sshKeyFileName"
	fi

	ask_for_confirmation "do you want to add ssh key to github? (It is necessary to set the API key correctly in advance)"
	if answer_is_yes; then
		add_public_key_to_github "${sshKeyFileName}.pub"

		ask_for_confirmation "Do you want to update the content from the 'dotfiles' directory?"
		if answer_is_yes; then

			git fetch --all 1>/dev/null &&
				git reset --hard origin/master 1>/dev/null &&
				git clean -fd 1>/dev/null

			print_result $? "Update content"
		fi
	else
		print_warning "set SSH key manually (see https://github.com/settings/keys)"
	fi
fi
