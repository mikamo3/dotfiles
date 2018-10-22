#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../utils.sh"

run_scripts "./common/before_symlink"
run_scripts "./$(get_os)/before_symlink"

"./common/symlink.sh"
"./$(get_os)/symlink.sh"

run_scripts "./common/after_symlink"
run_scripts "./$(get_os)/after_symlink"
