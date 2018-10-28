#!/bin/bash
# Build a new environment
# 1.Download tarball from github repository (If this script is not running locally)
# 2.Install necessary items based on the package list
# 3.Create symbolic links

declare -r GITHUB_REPOSITORY="mikamo3/dotfiles"
declare -r TARBALL_URL="https://github.com/$GITHUB_REPOSITORY/tarball/master"

download() {
  local url="$1"
  local dst_path="$2"

  if command -v curl &>/dev/null; then
    curl -LsSo "$dst_path" "$url"
  elif command -v "wget" &>/dev/null; then
    wget -qO "$dst_path" "$url"
  else
    print_error "need curl or wget command."
    return 1
  fi
  return $?
}

extract() {
  local source_file_path=$1
  local dst_path=$2
  if command -v tar &>/dev/null; then
    tar -zxf "$source_file_path" --strip-components 1 -C "$dst_path"
    return $?
  fi
  reutrn 1
}

#print function
print_error_log() {
  while read -r line; do
    print_error "   $line\n"
  done
}
print_error() {
  print_color "1" "[❌]$1\n"
}
print_success() {
  print_color "2" "[✅]$1\n"
}
print_info() {
  print_color "4" "$1\n"
}
print_warn() {
  print_color "3" "$1\n"
}
print_title() {
  print_color "5" "$1\n"
}
print_color() {
  local color=$1
  local string=$2
  printf "%b" "$(tput setaf "$color" 2>/dev/null)" "$string" "$(tput sgr0 2>/dev/null)"
}

confirm() {
  local string=$1
  print_warn "$string"
  read -r
}

ask_for_confirmation() {
  local string=$1
  print_warn "$string (y/n) :"
  read -r -n 1
}

answer_is_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]] && return 0 || return 1
}

main() {
  local download_temp_file
  local dotfiles_path="$HOME/.dotfiles"
  #TODO: print ascii art

  cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

  #when execute
  if ! printf "%s" "${BASH_SOURCE[0]}" | grep -q "bootstrap.sh"; then
    #download
    print_title "Download dotfiles Repository...\n"
    print_info "  url:$TARBALL_URL\n"
    download_temp_file=$(mktemp)
    download "$TARBALL_URL" "$download_temp_file" || exit 1
    print_info "Download complete!\n"

    #extract
    print_title "Extracting\n"
    ask_for_confirmation "Dottiles will extracrted to '$dotfiles_path'. Are you sure? :"
    if ! answer_is_yes; then
      confirm "Where will you extract dotfiles to? (default: $dotfiles_path) :"
      dotfiles_path=$(eval "echo $REPLY")

    fi

    #when $dotfiles_path exists
    while [[ -e "$dotfiles_path" ]]; do
      ask_for_confirmation "$dotfiles_path is already exists. Do you overwrite it? :"
      if answer_is_yes; then
        rm -rf "$dotfiles_path"
      else
        confirm "Where will you extract dotfiles to? :"
        dotfiles_path=$(eval "echo $REPLY")
      fi
    done
    mkdir -p "$dotfiles_path"
    print_info "Create Directory:$dotfiles_path"
    print_info "   from: $download_temp_file to: $dotfiles_path"
    extract "$download_temp_file" "$dotfiles_path"
    print_info "Extract complete"
  else
    dotfiles_path="$(readlink -f "$(pwd)/..")"
  fi
  print_info "dotfiles directory :$dotfiles_path"
  cd "$dotfiles_path/src/os" || exit 1

  ./install.sh || exit 1
  ./symlink.sh || exit 1
  ./initialize_dotfiles_repository.sh "$GITHUB_REPOSITORY" || exit 1
}
main "$@"
