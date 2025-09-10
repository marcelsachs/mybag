#!/bin/bash

set -e

git clone --depth=1 https://github.com/vim/vim.git $HOME/vim
cd vim/src

./configure --with-features=huge \
            --with-x=yes

make -j$(nproc)
sudo make install

vim --version | grep clipboard
