#!/bin/sh

echo "=== Cloning stacks-blockchain-docker repo to /opt/stacks-blockchain-docker ==="
git clone --depth 1 https://github.com/stacks-network/stacks-blockchain-docker /opt/stacks-blockchain-docker

echo "=== Copying sample.env to /opt/stacks-blockchain-docker/.env ==="
cp -a /opt/stacks-blockchain-docker/sample.env /opt/stacks-blockchain-docker/.env
mkdir /opt/stacks-blockchain-docker/persistent-data

# # BNS is enabled/downloaded in 03-bns.sh

# echo "=== Enable stacks-blockchain-api fungible metadata ==="
# sed -i -e 's|# STACKS_API_ENABLE_FT_METADATA|STACKS_API_ENABLE_FT_METADATA|' /opt/stacks-blockchain-docker/.env

# echo "=== Enable stacks-blockchain-api non-fungible metadata ==="
# sed -i -e 's|# STACKS_API_ENABLE_NFT_METADATA|STACKS_API_ENABLE_NFT_METADATA|' /opt/stacks-blockchain-docker/.env

echo "=== Enable stacks.service on boot ==="
systemctl enable stacks