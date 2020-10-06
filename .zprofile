# Configure Ruby
eval "$(rbenv init -)"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# BOSH
export BOSH_LOG_PATH="$(mktemp)"
export BOSH_LOG_LEVEL=debug
