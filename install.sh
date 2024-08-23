#!/bin/sh

set -eu

cd "$HOME/dotfiles/dotfiles"

find . -type d | cut -b 3- | xargs -I '{}' mkdir -p "$HOME/{}"
find . -type f | cut -b 3- | xargs -I '{}' ln -snfv "$HOME/dotfiles/dotfiles/{}" "$HOME/{}"

find . -type d | cut -b 3- | xargs -I '{}' chmod 755 "$HOME/{}"
find . -type f | cut -b 3- | xargs -I '{}' chmod 755 "$HOME/{}"

chmod 700 -R "$HOME/dotfiles"
chmod 600 "$HOME/dotfiles/dotfiles/.ssh/authorized_keys"

echo "Dotfiles install success"
