#!/bin/sh

echo === Installing pre-requisites for Docker ===
apt-get update -y
apt-get remove -y docker docker-engine docker.io containerd runc
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    git \
    jq \
    ufw
echo === Downloading Docker GPG keyring ===
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo === Adding Docker repo to apt sources ===

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

echo === Installing Docker ===
apt-get update -y && apt-get install -y docker-ce docker-ce-cli containerd.io
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose