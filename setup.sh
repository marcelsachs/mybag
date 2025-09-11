#!/bin/bash

set -e

echo "Starting system setup..."

sudo timedatectl set-ntp true

echo "Installing packages with pacman..."
sudo pacman -S --needed --noconfirm sway foot wmenu git vim base-devel

echo "Copying home directory configurations..."
cp .bashrc "$HOME/.bashrc"
cp .vimrc "$HOME/.vimrc" 
cp .gitconfig "$HOME/.gitconfig"

echo "Configuring git..."
git config --global user.name "marcelsachs"
git config --global user.email "sachsmarcel@proton.me"
git config --global init.defaultBranch master

if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "Generating SSH key..."
    ssh-keygen -t ed25519 -C "sachsmarcel@proton.me" -f ~/.ssh/id_ed25519 -N ""
else
    echo "SSH key already exists at ~/.ssh/id_ed25519"
fi

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
echo "Public SSH key:"
cat ~/.ssh/id_ed25519.pub

if command -v xclip > /dev/null && [ -n "$DISPLAY" ]; then
    cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "Public key copied to clipboard with xclip."
    else
        echo "Could not copy to clipboard. Copy the key manually."
    fi
else
    echo "No graphical display available. Copy the key manually."
fi

echo "Test SSH connection with: ssh -T git@github.com"

echo "Installing yay AUR helper..."
if ! command -v yay &> /dev/null; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
    echo "yay installed successfully"
else
    echo "yay is already installed"
fi

echo "Building vim from source..."
if [ ! -d "$HOME/vim" ]; then
    git clone --depth=1 https://github.com/vim/vim.git $HOME/vim
fi

cd $HOME/vim/src
./configure --with-features=huge \
            --with-x=yes

make -j$(nproc)
sudo make install

echo "Vim built and installed. Checking clipboard support:"
vim --version | grep clipboard

echo "Configuring sway, foot, and i3status..."

mkdir -p "$HOME/.config/i3status"
mkdir -p "$HOME/.config/foot"
mkdir -p "$HOME/.config/sway"

cp -r .config/* "$HOME/.config/"

echo "Setup OK! Get to work now."
