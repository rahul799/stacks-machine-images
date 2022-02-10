#!/bin/sh
echo === Cloning stacks-blockchain-docker repo ===
git clone https://github.com/stacks-network/stacks-blockchain-docker /opt/stacks-blockchain-docker

echo === Copying sample.env to /opt/stacks-blockchain-docker/.env ===
cp -a /opt/stacks-blockchain-docker/sample.env /opt/stacks-blockchain-docker/.env
mkdir /opt/stacks-blockchain-docker/persistent-data

echo === Enable stacks.service on boot ===
systemctl enable stacks