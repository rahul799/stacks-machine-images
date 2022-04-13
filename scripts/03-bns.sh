#!/bin/sh

echo "=== Enable stacks-blockchain-api BNS data ==="
sed -i -e 's|# BNS_IMPORT_DIR|BNS_IMPORT_DIR|' /opt/stacks-blockchain-docker/.env

echo "=== Downloading BNS Data ==="
export BNS_IMPORT_DIR="/opt/stacks-blockchain-docker/persistent-data/bns-data" && \
    mkdir -p ${BNS_IMPORT_DIR} && \
    /opt/stacks-blockchain-docker/scripts/setup-bns.sh
unset BNS_IMPORT_DIR
