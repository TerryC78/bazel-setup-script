#!/bin/bash
#
# Scripts to install pyenv and install python3 as global default version in GCE instance.

# pyenv dependencies
# https://github.com/pyenv/pyenv/wiki/Common-build-problems
sudo apt-get install -y git-all make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev

# pyenv-installer
# https://github.com/pyenv/pyenv-installer
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# in ~/.bashrc
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
