# runtime ================

autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit && compinit

if type "brew" &> /dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if type "deno" > /dev/null 2>&1; then
  export DENO_INSTALL="$HOME/.deno"
fi

if type "mise" > /dev/null 2>&1; then
  eval "$(mise activate zsh)"
  eval "$(mise activate --shims)"
elif type "asdf" > /dev/null 2>&1; then
  fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
fi

if type "ghr" > /dev/null 2>&1; then
  source <(ghr shell bash)
  source <(ghr shell bash --completion)
fi

if type "sccache" > /dev/null 2>&1; then
  export RUSTC_WRAPPER=$(which sccache)
fi

if docker compose &> /dev/null 2>&1; then
  source <(docker completion zsh)
fi
