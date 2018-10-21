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
sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install -y docker-ce
# sudo apt-get install -y docker-ce=18.03.1~ce-0~debian

######################################
#
# Endpoints & GCE example
#   https://cloud.google.com/endpoints/docs/openapi/get-started-compute-engine-docker
#
######################################
# on laptop/workstation
git clone https://github.com/GoogleCloudPlatform/java-docs-samples
cd java-docs-samples/endpoints/getting-started
vim openapi.yaml
gcloud endpoints services deploy openapi.yaml

# on GCE with Docker installed
sudo docker network create --driver bridge esp_net
sudo docker run --detach --name=echo --net=esp_net gcr.io/google-samples/echo-java:1.0
sudo docker run \
    --name=esp \
    --detach \
    --publish=80:8080 \
    --net=esp_net \
    gcr.io/endpoints-release/endpoints-runtime:1 \
    --service=echo-api.endpoints.tianyuc-cloud-esf.cloud.goog \
    --rollout_strategy=managed \
    --backend=echo:8080
    
# Step 7: curl by
curl --request POST \
   --header "content-type:application/json" \
   --data '{"message":"hello world"}' \
   "http://[IP_ADDRESS]:80/echo?key=${ENDPOINTS_KEY}"

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
