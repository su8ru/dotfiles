su8ru's dotfiles.

## setup

### Install mise

```sh
curl https://mise.run | sh
eval "$(mise activate zsh)"
```

### Initialize chezmoi

```sh
mise exec chezmoi@latest -- chezmoi init https://github.com/su8ru/dotfiles
cd ~/.local/share/chezmoi
mise trust
mise run diff
mise run setup
mise run vim:install
exec zsh -l
```

### [WSL2] Mask native gpg-agent

Install `socat`, then:

```sh
cd ~/.local/share/chezmoi
mise run wsl2:mask-gpg-agent
```

## update

```sh
cd ~/.local/share/chezmoi
mise run update
```
