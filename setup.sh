#!/bin/bash
#
# Environment setup script for GCE instance.

# system upgrade
sudo apt-get update -y
sudo apt-get upgrade -y

#######################################
#
# Dev tools
#
#######################################
sudo apt-get install -y tmux \
                        zsh \
                        git-all

######################################
#
# Bazel environment
#
######################################
sudo apt-get install -y pkg-config zip g++ zlib1g-dev unzip python
wget https://github.com/bazelbuild/bazel/releases/download/0.17.2/bazel-0.17.2-installer-linux-x86_64.sh
chmod +x bazel-0.17.2-installer-linux-x86_64.sh
./bazel-0.17.2-installer-linux-x86_64.sh --user

export PATH="$PATH:$HOME/bin"
echo 'export PATH="$PATH:$HOME/bin"' >> ~/.bashrc
source ~/.bashrc
sudo rm bazel-0.17.2-installer-linux-x86_64.sh

# sudo apt-get install -y clang-format-7
sudo apt-get install -y libtool cmake realpath automake ninja-build curl

######################################
#
# Docker 
#   https://docs.docker.com/install/linux/docker-ce/debian/
#
######################################
sudo apt-get update
sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install docker-ce
sudo apt-get install docker-ce=18.03.1~ce-0~debian

######################################
#
# Envoy filter example
#
######################################
# cd $HOME
# git clone https://github.com/envoyproxy/envoy-filter-example.git
# cd envoy-filter-example
# git submodule update --init
# bazel build //:envoy

# Oh my zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# echo 'export PATH="$PATH:$HOME/bin"' >> ~/.zshrc
# export PATH="$PATH:$HOME/bin"
