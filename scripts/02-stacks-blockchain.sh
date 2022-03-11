#!/bin/sh

echo "=== Cloning stacks-blockchain-docker repo to /opt/stacks-blockchain-docker ==="
git clone --depth 1 https://github.com/stacks-network/stacks-blockchain-docker /opt/stacks-blockchain-docker

echo "=== Copying sample.env to /opt/stacks-blockchain-docker/.env ==="
cp -a /opt/stacks-blockchain-docker/sample.env /opt/stacks-blockchain-docker/.env
mkdir /opt/stacks-blockchain-docker/persistent-data

echo "=== Enable stacks-blockchain-api BNS_IMPORT_DIR ==="
sed -i -e 's|# BNS_IMPORT_DIR|BNS_IMPORT_DIR|' /opt/stacks-blockchain-docker/.env

echo "=== Enable stacks.service on boot ==="
systemctl enable stacks