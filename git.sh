#!/bin/bash

git config --global user.name "marcelsachs"
git config --global user.email "sachsmarcel@proton.me"
git config --global init.defaultBranch master

if [ ! -f ~/.ssh/id_ed25519 ]; then
    ssh-keygen -t ed25519 -C "sachsmarcel@proton.me" -f ~/.ssh/id_ed25519 -N ""
else
    echo "SSH key already exists at ~/.ssh/id_ed25519"
fi

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
echo "Public SSH key:"
cat ~/.ssh/id_ed25519.pub
if command -v xclip > /dev/null; then
    cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
    echo "Public key copied to clipboard with xclip."
else
    echo "Install xclip or copy the key manually."
fi

echo "test with:"
echo "ssh -T git@github.com"
