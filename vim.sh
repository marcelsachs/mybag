#!/bin/bash

set -e

git clone https://github.com/vim/vim.git
cd vim/src

./configure --with-features=huge \
            --with-x=yes

make -j$(nproc)
sudo make install

vim --version | grep clipboard
