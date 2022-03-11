#!/bin/sh

echo "=== Setting up docker per https://docs.docker.com/engine/install/debian/ ==="
apt-get update -y
echo "=== Remove any currently old versions Docker (none should be present) ==="
apt-get remove -y docker docker-engine docker.io containerd runc
echo "=== Installing pre-requisites for Docker ==="
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    git \
    jq \
    ufw
echo "=== Downloading Docker GPG keyring ==="
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "=== Adding Docker repo to apt sources ==="
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "=== Installing Docker and Compose==="
apt-get update -y && apt-get install -y docker-ce docker-ce-cli containerd.io
curl -L https://github.com/docker/compose/releases/download/$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
