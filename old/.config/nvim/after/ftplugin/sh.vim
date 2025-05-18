let g:ale_sh_shell_default_shell = 'bash'
let g:ale_sh_shfmt_options = '-i 2 -ln bash -bn'
let b:ale_fixers = ['shfmt']
let b:ale_linters = ['shellcheck']

