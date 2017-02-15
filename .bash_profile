#!/usr/bin/env bash

# start tmux by default
if command -v tmux>/dev/null; then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi

export PATH="${HOME}/bin:${PATH}"
