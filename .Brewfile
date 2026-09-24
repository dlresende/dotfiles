tap 'anomalyco/tap', trusted: true
tap 'carvel-dev/carvel', trusted: true
tap 'cloudfoundry/tap', trusted: true
tap 'hashicorp/tap', trusted: true
tap 'heroku/brew', trusted: true
tap 'neovim/neovim', trusted: true
tap 'ovh/tap', trusted: true

brew 'ack'
brew 'autoconf'
brew 'automake'
brew 'awscli'
brew 'azure-cli'
brew 'bash'
brew 'bash-language-server' # used by coc.nvim
brew 'bitwarden-cli'
brew 'block-goose-cli'
brew 'bosh-cli'
brew 'cabal-install'
brew 'chruby'
brew 'cmake'
brew 'coreutils'
brew 'csvkit'
brew 'direnv'
brew 'erlang'
brew 'fontconfig'
brew 'freetype'
brew 'fzf'
brew 'gcc' # required by sbt
brew 'gd'
brew 'gdbm'
brew 'gettext'
brew 'gh'
brew 'ghc'
brew 'git'
brew 'git-crypt'
brew 'go'
brew 'gopls'  # used by coc.nvim
brew 'gradle'
brew 'graphviz'
brew 'gron'
brew 'hashicorp/tap/vault'
brew 'helm'
brew 'heroku'
brew 'htop'
brew 'ipcalc'
brew 'java' unless system "/usr/libexec/java_home --failfast >/dev/null 2>&1"
brew 'jemalloc'
brew 'jpeg'
brew 'jq'
brew 'kapp'
brew 'kbld'
brew 'kind'
brew 'kubectl'
brew 'leiningen'
brew 'libevent'
brew 'libpng'
brew 'libssh'
brew 'libtermkey'
brew 'libtiff'
brew 'libtool'
brew 'libuv'
brew 'libvterm'
brew 'libxml2'
brew 'libxslt'
brew 'libyaml'
brew 'lua'
brew 'mas' if OS.mac?
brew 'maven'
brew 'mr'
brew 'msgpack'
brew 'neovim'
brew 'ngrep'
brew 'nmap'
brew 'node'
brew 'oci-cli'
brew 'opencode' if OS.linux?
brew 'openjdk'
brew 'openjdk@25', postinstall: "mkdir -p ${HOME}/Library/Java/JavaVirtualMachines && ln -sfn ${HOMEBREW_PREFIX}/opt/openjdk@25/libexec/openjdk.jdk ${HOME}/Library/Java/JavaVirtualMachines/openjdk-25.jdk" if OS.mac?
brew 'openldap'
brew 'openssh'
brew 'openssl'
brew 'opentofu'
brew 'perl' # required by mr
brew 'pmd'
brew 'python'
brew 'python-yq', args: ['force', 'overwrite']
brew 'rbenv'
brew 'readline' # required by ruby/rbenv
brew 'reattach-to-user-namespace' if OS.mac? # required by tmux plugin tmux-yank
brew 'ripgrep'    # required by coc.nvim
brew 'ruby-install'
brew 'ruff'        # used by coc.nvim (Python lint/format)
brew 'sbt'
brew 'scala'
brew 'shellcheck' # used by vim in conjunction with bash-language-server
brew 'solargraph'  # used by coc.nvim (Ruby LSP)
brew 'telnet' if OS.mac?
brew 'tig'
brew 'tmux'
brew 'tree'
brew 'typescript'
brew 'universal-ctags', args: ['HEAD'] # requried by vim/tagbar
brew 'vim'
brew 'watch'
brew 'webp'
brew 'wget'
brew 'xsel' if OS.linux? # required by tmux plugin tmux-yank, and VIm
brew 'yarn' # required by coc.vim
brew 'ytt'
brew 'zlib' if OS.linux? # required by ruby/rbenv

cask '1password' if OS.mac?
cask '1password-cli' if OS.mac?
cask 'adobe-acrobat-reader' if OS.mac?
cask 'android-platform-tools' if OS.mac?
cask 'android-studio' if OS.mac?
cask 'block-goose' if OS.mac?
cask 'caffeine' if OS.mac?
cask 'claude-code' if OS.mac?
cask 'docker-desktop' if OS.mac?
cask 'firefox' if OS.mac?
#cask 'fly'
cask 'flycut' if OS.mac?
cask 'gcloud-cli' if OS.mac?
cask 'iterm2' if OS.mac?
cask 'libreoffice' if OS.mac?
cask 'nextcloud' if OS.mac?
cask 'ovhcloud-cli' if OS.mac?
cask 'thunderbird' if OS.mac?
cask 'vlc' if OS.mac?

mas 'Xcode', id: 497799835 if OS.mac?

flatpak 'com.mattjakeman.ExtensionManager' if OS.linux?
flatpak 'com.protonvpn.www' if OS.linux?
flatpak 'com.slack.Slack' if OS.linux?
flatpak 'com.spotify.Client' if OS.linux?
flatpak 'org.audacityteam.Audacity' if OS.linux?
flatpak 'org.chromium.Chromium' if OS.linux?
flatpak 'org.libreoffice.LibreOffice' if OS.linux?
flatpak 'org.mozilla.thunderbird_esr' if OS.linux?
flatpak 'org.videolan.VLC' if OS.linux?
