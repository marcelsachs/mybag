#!/bin/bash

set -e

sudo timedatectl set-ntp true

cp .bashrc "$HOME/.bashrc"
cp .vimrc "$HOME/.vimrc" 
cp .gitconfig "$HOME/.gitconfig"

mkdir -p "$HOME/.config/i3status"
mkdir -p "$HOME/.config/foot"
mkdir -p "$HOME/.config/sway"

cp -r .config/* "$HOME/.config/"
