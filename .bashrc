#!/usr/bin/env bash

# Load dotfiles
for file in ~/.{aliases,path,exports,completions,dotfilesrc,functions}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

# Enable direnv
if command -v direnv > /dev/null
then
  eval "$(direnv hook bash)"
fi

# Append to the history file instead of overwriting 
shopt -s histappend

# Enable Homebrew
if command -v brew > /dev/null
then
  eval "$(brew shellenv)"
fi
