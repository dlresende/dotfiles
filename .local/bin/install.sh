#!/usr/bin/env bash

# Named install.sh (not install) so ~/.local/bin does not shadow POSIX /usr/bin/install in PATH

[ -z "$DEBUG" ] || set -x

: "${BRANCH:=main}"

set -e # bail out early if any command fails
set -u # fail if we hit unset variables
set -o pipefail # fail if any component of any pipe fails

( cd "$HOME" || exit 1

  # On a genuinely fresh Mac, /usr/bin/git (provided by the Xcode Command
  # Line Tools) refuses to run at all until this is accepted - and that's
  # every git command below, starting right after this.
  if [ "$(uname -s)" = 'Darwin' ]
  then
    sudo -v
    sudo xcodebuild -license accept
  fi

  if ! command -v git &> /dev/null
  then
    >&2 cat <<EOF
    git is not present in PATH. You should make sure git is installed and
    present in PATH before proceeding.
EOF
    exit 1
  fi

  if [ -d .git ]
  then
    echo "dotfiles repo already exists in ~. Updating to the latest main..."
  else
    git init
    git remote add origin https://github.com/dlresende/dotfiles.git
  fi

  git pull origin "$BRANCH"

  # shellcheck source=/dev/null
  source ~/.bashrc
  .local/bin/pimp-my-ride
)
