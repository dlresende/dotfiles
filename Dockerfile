# check=skip=FromPlatformFlagConstDisallowed
# Pinned to amd64: Homebrew-on-Linux publishes no arm64 bottles
# hadolint ignore=DL3029
FROM --platform=linux/amd64 ubuntu:24.04@sha256:008173c23f95b170204355c12626cb5a965d779a7e1283b09e9cffbb1bf33ca3

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

LABEL org.opencontainers.image.title="dotfiles" \
      org.opencontainers.image.description="Full-fidelity dotfiles development environment" \
      org.opencontainers.image.source="https://github.com/dlresende/dotfiles" \
      org.opencontainers.image.base.name="ubuntu:24.04"

ARG DEBIAN_FRONTEND=noninteractive

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

# No init system: stop postinst starting services
RUN printf '#!/bin/sh\nexit 101\n' > /usr/sbin/policy-rc.d && \
    chmod 0755 /usr/sbin/policy-rc.d

# Homebrew refuses to run as root; pimp-my-ride uses sudo
# --no-create-home: /etc/skel's .bashrc/.profile in $HOME would make install.sh's git pull abort with untracked conflicts
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

ARG BRANCH=main
ARG DEBUG=""
COPY --chown=dev:dev .local/bin/install.sh /tmp/install.sh
# hadolint ignore=DL3004,SC3046
RUN /tmp/install.sh && \
    source ~/.bashrc && \
    brew cleanup --prune=all -s && \
    rm -rf "$(brew --cache)" ~/.cache /tmp/install.sh && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash", "-l"]
