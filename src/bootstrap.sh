#!/bin/bash
# Build a new environment
# 1.Download tarball from github repository (If this script is not running locally)
# 2.Install necessary items based on the package list
# 3.Create symbolic links

declare -r GITHUB_REPOSITORY="mikamo3/dotfiles"
declare -r TARBALL_URL="https://github.com/$GITHUB_REPOSITORY/tarball/master"
declare -r UTILS_URL="https://raw.githubusercontent.com/$GITHUB_REPOSITORY/master/src/utils.sh"

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

main() {
  local download_temp_file
  local dotfiles_path="$HOME/.dotfiles"
  local download_util_file
  #TODO: print ascii art

  cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

  #when execute
  if ! printf "%s" "${BASH_SOURCE[0]}" | grep -q "bootstrap.sh"; then
    #download utils.sh
    download_util_file=$(mktemp)
    printf "%s" "Download utils.sh..."
    download "$UTILS_URL" "$download_util_file" && . "$download_util_file" && rm -rf "$download_util_file"

    #download
    print_title "Download dotfiles Repository..."
    print_info "  url:$TARBALL_URL"
    download_temp_file=$(mktemp)
    download "$TARBALL_URL" "$download_temp_file" || exit 1
    print_info "Download dotfiles Repository complete!"

    #extract
    print_title "Extracting dotfiles tarball"
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
    rm -rf "$download_temp_file"
    print_info "Extract complete"
  else
    . ./utils.sh
    dotfiles_path="$(readlink -f "$(pwd)/..")"
  fi
  print_info "dotfiles directory :$dotfiles_path"
  cd "$dotfiles_path/src/os" || exit 1

  ./install.sh || exit 1
  ./symlink.sh || exit 1
  ./initialize_dotfiles_repository.sh "$GITHUB_REPOSITORY" || exit 1
}
main "$@"
