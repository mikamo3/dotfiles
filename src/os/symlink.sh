#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../utils.sh"

create_symlink() {
  local -r source_dir=$1
  local -r target_base_dir=$2
  local -r exclude_files=(".gitkeep" ".DS_Store")
  local source_absolute_dir
  local target_absolute_base_dir

  #check directory
  if [[ ! -d "$source_dir" ]]; then
    print_error "$source_dir - is not a directory"
    return 1
  fi
  if [[ ! -d "$target_base_dir" ]]; then
    print_error "$target_base_dir - is not a directory"
    return 1
  fi
  source_absolute_dir=$(readlink -f "$source_dir")
  target_absolute_base_dir=$(readlink -f "$target_base_dir")

  #create_symlink
  while IFS= read -r -d '' source_path <&3; do
    local target_absolute_path=$target_absolute_base_dir${source_path/$source_absolute_dir/}
    if [[ "$target_absolute_base_dir" == "$target_absolute_path" ]]; then
      continue
    fi

    # skip exclude file
    for exclude_file in "${exclude_files[@]}"; do
      if [[ $(basename "$source_path") == "$exclude_file" ]]; then
        continue
      fi
    done

    if [[ -d "$source_path" ]]; then
      mkd "$target_absolute_path"
      continue
    fi
    if [[ -e "$target_absolute_path" ]]; then
      ask_for_confirmation "$target_absolute_path is already exists. Do you want to overwrite it?"
      if ! answer_is_yes; then
        print_warn "$target_absolute_path skipped.\n"
        continue
      fi
    fi
    execute "ln -sf $source_path $target_absolute_path" "$source_path → $target_absolute_path"
  done 3< <(find "$source_absolute_dir" -print0)
}

main() {
  print_title "Symlink \n\n"
  check_os || return 1

  print_title "Run before symlink(common)\n"
  run_scripts "./common/before_symlink"
  print_info "Run before symlink(common) complete\n"

  print_title "Run before symlink($(get_os))\n"
  run_scripts "./$(get_os)/before_symlink"
  print_info "Run before symlink($(get_os)) complete\n"

  print_title "Create symlink (common)...\n"
  create_symlink "../../dots/common" "$HOME"
  print_info "Create symlink (common) complete\n"

  print_title "Create symlink ($(get_os))...\n"
  create_symlink "../../dots/$(get_os)" "$HOME"
  print_info "Create symlink ($(get_os)) complete\n"

  print_title "Run after symlink(common)\n"
  run_scripts "./common/after_symlink"
  print_info "Run after symlink(common) complete\n"

  print_title "Run after symlink($(get_os))\n"
  run_scripts "./$(get_os)/after_symlink"
  print_info "Run after symlink($(get_os)) complete\n"
}
main "$@"
