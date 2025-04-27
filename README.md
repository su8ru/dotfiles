su8ru's dotfiles.

## setup

### 1. Install chezmoi

| Homebrew  | Pacman    |
| --------- | --------- |
| `chezmoi` | `chezmoi` |

or install binary in `./.local/bin` with a single command:

```sh
sh -c "$(curl -fsLS get.chezmoi.io/lb)"
```

### 2. Initialize chezmoi

```sh
chezmoi init https://github.com/su8ru/dotfiles
chezmoi diff
chezmoi apply -v
```

### 3. Install other packages

| Package    | Homebrew    | Pacman        |
| ---------- | ----------- | ------------- |
| asdf       | `asdf`      | AUR `asdf-vm` |
| delta      | `git-delta` | `git-delta`   |
| GitHub CLI | `gh`        | `github-cli`  |

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
chezmoi update -v
```
