#!/bin/bash
get_os() {
  local os=""
  local kernelName="$(uname -s)"
  if [ "$kernelName" == "Darwin" ]; then
    os="macos"
  elif [ "$kernelName" == "Linux" ]; then
    if [ -e "/etc/debian_version" ] || [ -e "/etc/debian_release" ]; then
      if [ -e "/etc/lsb-release" ]; then
        os="ubuntu"
      else
        os="debian"
      fi
    elif [ -e "/etc/arch-release" ]; then
      os="arch"
    fi
  else
    os="other"
  fi
  printf "%s" "$os"
}
