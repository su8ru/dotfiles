su8ru's dotfiles.

## setup

### 1. Install mise

```sh
curl https://mise.run | sh
eval "$(mise activate zsh)"
```

### 2. Initialize chezmoi

```sh
mise exec chezmoi -- chezmoi init https://github.com/su8ru/dotfiles
mise exec chezmoi -- chezmoi diff
mise exec chezmoi -- chezmoi apply -v
exec zsh -l
```

### 3. Install other packages

```sh
mise install
```

### 4. (WSL2) Mask native gpg-agent

Install `socat`, then:

```sh
systemctl --user mask gpg-agent.socket
systemctl --user mask gpg-agent-ssh.socket
systemctl --user mask gpg-agent-extra.socket
systemctl --user mask gpg-agent-browser.socket
systemctl --user mask gpg-agent.service
```

## update

```sh
mise upgrade
chezmoi update -v
mise install
```
