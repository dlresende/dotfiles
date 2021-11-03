#!/usr/bin/env bash

# .bash_profile normally runs only once when you login, and the .bashrc for
# every new interactive shell.  However, Terminal.app on macOS, does not follow
# this convention. When Terminal.app opens a new window, it will run
# .bash_profile.
if [[ -r "${HOME}/.bashrc" ]]; then
	# shellcheck source=/dev/null
	source "${HOME}/.bashrc"
fi

