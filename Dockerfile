# check=skip=FromPlatformFlagConstDisallowed
# Pinned to amd64: the digest below is a multi-arch index, and Homebrew-on-Linux
# publishes no arm64 bottles, so an arm64 resolution would build ~95 formulae from source.
# hadolint ignore=DL3029
FROM --platform=linux/amd64 ubuntu:24.04@sha256:008173c23f95b170204355c12626cb5a965d779a7e1283b09e9cffbb1bf33ca3

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

LABEL org.opencontainers.image.title="dotfiles" \
      org.opencontainers.image.description="Full-fidelity dotfiles development environment" \
      org.opencontainers.image.source="https://github.com/dlresende/dotfiles" \
      org.opencontainers.image.base.name="ubuntu:24.04"

ARG DEBIAN_FRONTEND=noninteractive

# Base packages required for initial bootstrap. Build dependencies (build-essential,
# procps, file) are intentionally omitted so pimp-my-ride's install_stuff() installs and tests them.
# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      git \
      locales \
      sudo \
      tzdata && \
    sed -i 's/^# *\(en_GB.UTF-8 UTF-8\)/\1/' /etc/locale.gen && \
    locale-gen en_GB.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

# Prevent service restarts and daemon invocations in headless container build
RUN printf '#!/bin/sh\nexit 101\n' > /usr/sbin/policy-rc.d && \
    chmod 0755 /usr/sbin/policy-rc.d

# Pre-seed flatpak and flathub remote so remote failures surface early
# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends flatpak && \
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && \
    rm -rf /var/lib/apt/lists/*

# useradd without --create-home avoids /etc/skel skeleton files conflicting with dotfiles.
# Homebrew requires a non-root user with write access to /home/linuxbrew/.linuxbrew.
RUN userdel --remove ubuntu && \
    groupadd --gid 1000 dev && \
    useradd --no-create-home --uid 1000 --gid 1000 --shell /bin/bash dev && \
    install -d -m 0755 -o dev -g dev /home/dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-dev && \
    chmod 0440 /etc/sudoers.d/90-dev && \
    install -d -m 0755 -o dev -g dev /home/linuxbrew /home/linuxbrew/.linuxbrew

ENV HOME=/home/dev \
    LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB:en \
    LC_ALL=en_GB.UTF-8 \
    HOMEBREW_NO_ANALYTICS=1 \
    HOMEBREW_NO_ENV_HINTS=1 \
    HOMEBREW_BUNDLE_FLATPAK_SKIP="com.mattjakeman.ExtensionManager com.protonvpn.www com.slack.Slack com.spotify.Client org.audacityteam.Audacity org.chromium.Chromium org.libreoffice.LibreOffice org.mozilla.thunderbird_esr org.videolan.VLC"

# hadolint ignore=DL3066
USER dev
WORKDIR /home/dev

# Copy only bootstrap-required dotfiles so doc/config edits do not invalidate the expensive build layer
COPY --chown=1000:1000 .Brewfile .aliases .bash_profile .bashrc .completions .exports .functions .gemrc .gitconfig .path .tmux.conf ./
COPY --chown=1000:1000 .local .local

# configure_git links pre-commit hook into $HOME/.git/hooks; initializing git repo matches install.sh
RUN git init --initial-branch=main . && \
    git remote add origin https://github.com/dlresende/dotfiles.git

# Sourcing .bashrc sets HOMEBREW_PREFIX needed by .path before running pimp-my-ride.
# Caches and package lists are pruned in the same RUN layer to minimize immutable image size.
ARG DEBUG=""
# hadolint ignore=DL3004,SC3046
RUN source "${HOME}/.bashrc" && \
    .local/bin/pimp-my-ride && \
    brew cleanup --prune=all -s && \
    rm -rf "$(brew --cache)" "${HOME}/.cache" && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

# Copy remaining tracked files after the expensive bootstrap layer
COPY --chown=1000:1000 .XCompose .gitignore .tigrc CNAME README.md _config.yml ./
COPY --chown=1000:1000 .github .github

# Login shell sources .bash_profile -> .bashrc -> .path as the single source of truth for PATH
CMD ["/bin/bash", "-l"]
