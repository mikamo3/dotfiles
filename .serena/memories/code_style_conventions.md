# Code Style and Conventions

## Shell Scripts (Bash)
- Use `#!/usr/bin/env bash` shebang
- Use `set -e` for error handling
- Use double quotes for variable expansion
- Use descriptive variable names in UPPER_CASE for environment variables
- Include error checking and user feedback with echo statements

## Fish Shell Configuration
- Use `set -Ux` for universal exported variables
- Use `set PATH` for path modifications
- Source external configurations at the end of config files
- Use conditional checks with `status is-interactive` for interactive-only features

## Configuration Files
- Use consistent indentation (usually 2 or 4 spaces)
- Group related configurations together
- Include comments for complex configurations
- Follow the specific format requirements of each tool

## Git Configuration
- Use meaningful aliases for common operations
- Keep commit messages concise and descriptive
- Use conventional commit format when applicable

## File Organization
- Keep configurations organized by application in `.config/` directory
- Use descriptive filenames
- Separate application-specific scripts in dedicated directories