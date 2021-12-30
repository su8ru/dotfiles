#!/bin/sh

set -eu

USER="subaru"

cd "/home/$USER/dotfiles/dotfiles"

find . -type d | cut -b 3- | xargs -I '{}' mkdir -p "/home/$USER/{}"
find . -type f | cut -b 3- | xargs -I '{}' ln -snfv "/home/$USER/dotfiles/dotfiles/{}" "/home/$USER/{}"

find . -type d | cut -b 3- | xargs -I '{}' chmod 755 "/home/$USER/{}"
find . -type f | cut -b 3- | xargs -I '{}' chmod 755 "/home/$USER/{}"

chmod 600 "/home/$USER/dotfiles/dotfiles/.ssh/authorized_keys"

echo "Dotfiles install success"
