# dotfiles

Personal cross-platform dotfiles and bootstrap system for macOS and Linux (Ubuntu).

## Installation

To bootstrap a fresh machine:

```bash
curl -fsSL https://dotfiles.diegolemos.net/.local/bin/install.sh | bash
```

### Bootstrap Workflow

1. **`.local/bin/install.sh`**: Initializes or updates the dotfiles repository in `~` from `main`, accepts the Xcode license on macOS, and runs `pimp-my-ride`.
2. **`.local/bin/pimp-my-ride`**: Automates full environment configuration:
   - Installs system packages (apt & Flatpak on Linux, Homebrew on macOS/Linux).
   - Runs `brew bundle` using `.Brewfile` to install CLI tools, GUI applications (macOS casks / Linux Flatpaks), and fonts.
   - Installs and activates the latest Ruby via `rbenv`.
   - Configures Vim plugins, Tmux TPM plugins, and Git pre-commit hooks.
   - Applies platform-specific system settings (e.g., keyboard shortcuts on macOS, systemd lid-switch behavior on Linux).

---

## Repository Structure

```text
~
├── .bash_profile          # Login shell entry point (sources .bashrc)
├── .bashrc                # Interactive shell entry point; initializes direnv, Homebrew, and loads dotfiles
├── .path                  # PATH hierarchy: Go, Homebrew, Java (macOS), rbenv shims, ~/.local/bin
├── .exports               # Environment variables (OS, EDITOR, history, prompt, rbenv, Homebrew)
├── .aliases               # Common command shortcuts (delete_branches, python3 mappings)
├── .functions             # Custom shell functions (e.g., cleanup_branches)
├── .completions           # Custom Bash completion scripts
├── .curlrc                # Curl configuration (forces HTTP/1.1 for Homebrew)
├── .Brewfile              # Declarative package definitions (formulae, casks, flatpaks) with OS guards
├── .gitconfig             # Global Git settings (credential helper, untracked ~/.gitconfig.local include)
├── .tmux.conf             # Tmux configuration & TPM plugin management
├── .tigrc                 # Tig keybindings & git-duet commit integration
├── .gemrc                 # RubyGems configuration
├── .XCompose              # Custom character composition keys (Linux)
└── .local/
    ├── bin/               # Custom CLI scripts & utilities
    │   ├── install.sh     # Remote bootstrap installer
    │   ├── pimp-my-ride   # Machine setup & package provisioning
    │   ├── git-duet       # Pair programming identity management
    │   ├── git-duet-commit# Git commit wrapper with duet authoring
    │   ├── git-solo       # Reset duet pairing to solo author
    │   └── git/hooks/     # Git hooks (pre-commit)
    └── etc/               # System configuration overrides
        ├── macos/         # macOS system settings (symbolic hotkeys)
        └── systemd/       # Systemd unit/configuration overrides (Linux)
```

---

## Shell Architecture

Dotfiles are loaded by `.bashrc` in the following sequence:

1. **`direnv` hook**: Initializes direnv.
2. **`brew shellenv`**: Dynamically exports Homebrew paths (`$HOMEBREW_PREFIX`, `$PATH`, `$MANPATH`).
3. **Dotfiles sourcing**: `~/.{aliases,path,exports,completions,dotfilesrc,functions}`
   - **`.path`**: Guarantees `$HOME/.local/bin` and `$HOME/.rbenv/shims` precede Homebrew binaries on `$PATH`.
   - **`.exports`**: Sets `$OS`, exports editor/locale defaults, configures extended history capture via `PROMPT_COMMAND` / `DEBUG` trap, and specifies Ruby build flags.
   - **`.functions`**: Provides utilities such as `cleanup_branches` (safely removes local branches merged into the current branch).

---

## Post-Installation Notes

### Linux Key Remapping

To map `Ctrl` shortcuts to `Cmd` (Super):

#### Firefox
1. Open `about:config` in the address bar.
2. Search for `ui.key.accelKey`.
3. Set the value to `91`.

#### Thunderbird
1. Go to **Edit** > **Settings** > **General** > **Config Editor...**
2. Apply the same setting as [Firefox](#firefox).

---

## Licence

Copyright (c) 2017-2026 Diego Lemos

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
