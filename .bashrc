#!/usr/bin/env bash

# Enable direnv
# This must be configured before we load dotfiles below as this will append the
# _direnv_hook to the PROMPT_COMMAND variable, but we want to control the order
# of commands

# if command -v direnv > /dev/null
# then
#   eval "$(direnv hook bash)"
# fi

# Load dotfiles
for file in ~/.{aliases,exports,path,completions,dotfilesrc,functions}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

# Disable automatic history appending - we'll write manually to have full
# control and only save successful commands
shopt -u histappend

# Enable Homebrew
# if command -v brew > /dev/null
# then
#   /home/linuxbrew/.linuxbrew/bin/brew shellenv bash
# fi

# case "$( uname -s )" in
#   Darwin)
#     eval "$(brew shellenv)"
#     ;;
#   Linux)
#     eval "$( /home/linuxbrew/.linuxbrew/bin/brew shellenv bash )"
#     ;;
# esac
