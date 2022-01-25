#!/usr/bin/env bash

# Load dotfiles
for file in ~/.{aliases,path,exports,completions,dotfiles,functions}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

# Enable direnv
eval "$(direnv hook bash)"

# Configure Prompt
PS1="\n; "

# Append to the history file instead of overwriting 
shopt -s histappend
