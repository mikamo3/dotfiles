#!/bin/bash
# set timezone to Asia/Tokyo
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../../../utils.sh"
execute "sudo ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime"
