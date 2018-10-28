#!/bin/bash
# functions

#os function
run_scripts() {
  local sourceDir="$1"
  if [ ! -d "$sourceDir" ]; then
    print_error "$sourceDir is not directory"
    return 1
  fi
  while IFS= read -r -d '' script <&3; do
    "$script"
  done 3< <(find "$sourceDir" -name '*.sh' -print0)
}

get_os() {
  local os=""
  local kernelName=""
  kernelName="$(uname -s)"

  if [ "$kernelName" == "Darwin" ]; then
    os="macos"
  elif [ "$kernelName" == "Linux" ]; then
    if [ -e "/etc/lsb-release" ]; then
      os="ubuntu"
    elif [ -e "/etc/arch-release" ]; then
      os="arch"
    fi
  else
    os="$kernelName"
  fi
  printf "%s" "$os"
}

check_os() {
  #TODO: support ubuntu
  local os
  os=$(get_os)
  if [ "$os" == "arch" ]; then
    print_success "Check os OK ($os)"
    return 0
  fi
  print_error "This script is not supported $os"
  return 1
}

#print function
print_result() {
  if [[ "$1" -eq 0 ]]; then
    print_success "$2"
  else
    print_error "$2"
  fi
  return "$1"
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
  print_color "3" "$string :"
  read -r
}

ask_for_confirmation() {
  local string=$1
  print_color "3" "$string (y/n) :"
  read -r -n 1
  printf "\n"
}

answer_is_yes() {
  [[ "$REPLY" =~ ^[Yy]?$ ]] && return 0 || return 1
}

sudo_keepalive() {
  sudo -v
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &
}

execute() {
  local -r CMD=$1
  local -r MSG=${2:-${1}}
  eval "$CMD"
  print_result "$?" "$MSG"
}

mkd() {
  if [ -n "$1" ]; then
    if [ -e "$1" ]; then
      if [ ! -d "$1" ]; then
        print_error "$1 - a file with the same name already exists!"
      else
        print_success "$1"
      fi
    else
      execute "mkdir -p $1" "Create directory :$1"
    fi
  fi
}
