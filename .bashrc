#!/usr/bin/env bash

# Load dotfiles
for file in ~/.{aliases,exports,completions,dotfilesrc,functions}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

# .path needs OS and HOMEBREW_PREFIX from .exports above, so it's sourced
# separately, after the loop.
# shellcheck source=/dev/null
source ~/.path

# Enable direnv. Safe to run after loading dotfiles above: .exports's own
# PROMPT_COMMAND already calls _direnv_hook, and direnv's hook checks for
# that exact call before appending its own, regardless of order.
if command -v direnv > /dev/null
then
  eval "$(direnv hook bash)"
fi

# Disable automatic history appending - we'll write manually to have full
# control and only save successful commands
shopt -u histappend
