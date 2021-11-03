#!/usr/bin/env bash

for file in ~/.{aliases,path,exports,completions,dotfiles,functions}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

# Configure Prompt
PS1="\n; "

