# path ================

typeset -U path PATH

export PATH="\
/opt/homebrew/bin:\
/opt/homebrew/sbin:\
$HOME/.local/bin:\
$HOME/.yarn/bin:\
$HOME/.cargo/bin:\
$HOME/.composer/vendor/bin:\
/usr/local/custom:\
/usr/local/go/bin:\
$HOME/go/bin:\
$DENO_INSTALL/bin:\
$BREW_INSTALL/bin:\
${ASDF_DATA_DIR:-$HOME/.asdf}/shims:\
$PATH"
