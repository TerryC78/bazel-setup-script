#!/bin/bash
#
# Environment setup script for GCE instance.

# system upgrade
sudo apt-get update -y
sudo apt-get upgrade -y

#######################################
#
# Required tools
#
#######################################

# Tmux
sudo apt-get install tmux -y

# zsh
sudo apt-get install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Git
sudo apt-get install git-all -y

######################################
#
# Envoy environment
#
######################################
sudo apt-get install -y pkg-config zip g++ zlib1g-dev unzip python
wget https://github.com/bazelbuild/bazel/releases/download/0.17.2/bazel-0.17.2-installer-linux-x86_64.sh
chmod +x bazel-0.17.2-installer-linux-x86_64.sh
./bazel-0.17.2-installer-linux-x86_64.sh --user
export PATH="$PATH:$HOME/bin"
echo 'export PATH="$PATH:$HOME/bin"' >> ~/.zshrc
echo 'export PATH="$PATH:$HOME/bin"' >> ~/.basshrc
source ~/.bashrc

# sudo apt-get install -y clang-format-7
sudo apt-get install -y libtool cmake realpath automake ninja-build curl

######################################
#
# Envoy filter example
#
######################################
cd $HOME
git clone https://github.com/envoyproxy/envoy-filter-example.git
cd envoy-filter-example
git submodule update --init
bazel build //:envoy
