#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../utils.sh"
is_installed() {
  local query=$1
  if ! is_installed_package "$query"; then
    is_installed_group "$query"
  fi
}
is_installed_package() {
  local query=$1
  pacman -Q "$query" &>/dev/null
}
is_installed_group() {
  local query=$1
  local installed_group
  local remote_group
  installed_group=$(pacman -Qg "$query" &>/dev/null)
  #group not installed
  [[ $? == 1 ]] && return 1
  remote_group=$(pacman -Sg "$query" &>/dev/null)
  #group not fount
  [[ $? == 1 ]] && return 1
  diff <(printf "%s" "$installed_group") <(printf "%s" "$remote_group") &>/dev/null
}
concat_package_list() {
  local package_list_file=$1
  local output_list=""
  while read -r item; do
    item=$(printf "%s" "$item" | sed 's/#.*//g')
    if [[ "${item//[ ]/}" == "" ]]; then
      continue
    fi
    if ! is_installed "$item"; then
      output_list+=$(printf "%s" " $item")
    fi
  done <"$package_list_file"
  printf "%s" "$output_list"
}
main() {
  print_title "Install packages with pacman"
  local package_list
  execute "sudo pacman -Syu" "Upgrade packages"
  package_list=$(concat_package_list "../../../packages/arch/pacman-package-list")
  [[ "${package_list//[ ]/}" == "" ]] && print_success "There is no package to install" && return 0
  execute "sudo pacman -S $package_list" "Install packages"
}
main "$@"
