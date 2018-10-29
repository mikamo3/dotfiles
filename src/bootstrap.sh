#!/bin/bash
# Build a new environment
# 1.Download tarball from github repository and extract (If this script is not running locally)
# 2.Install necessary items based on the package list
# 3.Create symbolic links
# 4.Initialize dotfiles directory as git repository

declare -r GITHUB_REPOSITORY="mikamo3/dotfiles"
declare -r TARBALL_URL="https://github.com/$GITHUB_REPOSITORY/tarball/master"
declare -r UTILS_URL="https://raw.githubusercontent.com/$GITHUB_REPOSITORY/master/src/utils.sh"

declare dotfiles_path="$HOME/.dotfiles"

download() {
  local url="$1"
  local dst_path="$2"

  if command -v curl &>/dev/null; then
    curl -LsSo "$dst_path" "$url"
  elif command -v "wget" &>/dev/null; then
    wget -qO "$dst_path" "$url"
  else
    print_error "Need curl or wget command."
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

download_util_file() {
  local download_util_file
  download_util_file=$(mktemp)
  printf "%s\n" "Download utils.sh"
  printf "  %s\n" "url:$UTILS_URL"
  download "$UTILS_URL" "$download_util_file" &&
    . "$download_util_file" &&
    rm -rf "$download_util_file" &&
    print_success "Download utils.sh" &&
    return 0
  printf "%s\n" "Download utils.sh failed"
  return 1
}

download_dotfiles_tarball() {
  local download_temp_file

  #download
  print_title "Download dotfiles repository"
  print_info "  url:$TARBALL_URL"
  download_temp_file=$(mktemp)
  execute "download $TARBALL_URL $download_temp_file" "Download dotfiles repository" || return 1

  #extract tarball
  print_title "Extract dotfiles tarball"
  mkd "$dotfiles_path" || return 1

  print_title "Extract tarball"
  print_info "  from:$download_temp_file"
  print_info "  to: $dotfiles_path"
  execute "extract $download_temp_file $dotfiles_path &&\
    rm -rf \"$download_temp_file\"" "Extract tarball to:$dotfiles_path"
}
main() {
  #TODO: print ascii art

  cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1
  printf "%s\n" "dotfiles install"

  #when execute from url
  #download utils.sh then source it
  #download dotfiles tarball and extract it
  if ! printf "%s" "${BASH_SOURCE[0]}" | grep -q "bootstrap.sh"; then

    #download utils.sh
    download_util_file || exit 1
    check_os || exit 1

    #decide where to install dotfiles
    ask_for_confirmation "dotfiles will extracrted to '$dotfiles_path'. Are you sure?"
    if ! answer_is_yes; then
      confirm "Where will you extract dotfiles to? (default: $dotfiles_path)"
      [[ "$REPLY" != "" ]] && dotfiles_path=$(eval "echo $REPLY")
    fi

    if [[ -e "$dotfiles_path" ]]; then
      print_error "$dotfiles_path is already exists. Please remove this directory manually"
      exit 1
    fi

    #download dotfiles tarball and extract
    download_dotfiles_tarball || exit 1
  else
    . ./utils.sh
    dotfiles_path="$(readlink -f "$(pwd)/../")"
  fi
  print_info "  dotfiles directory :$dotfiles_path"
  cd "$dotfiles_path/src/os" || exit 1

  ./install.sh
  ./symlink.sh
  ./initialize_dotfiles_repository.sh

  print_success "Install complete"
}
main "$@"
