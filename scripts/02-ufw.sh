#!/bin/sh

# DigitalOcean Marketplace Image Validation Tool
# © 2021 DigitalOcean LLC.
# This code is licensed under Apache 2.0 license (see LICENSE.md for details)

echo === Configure ufs rules ===
ufw default deny incoming
ufw default allow outgoing

echo === Enable ufw port ingress ===
ufw limit ssh/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 3999/tcp
ufw allow 20443:20444/tcp

echo === Enable ufw.service on boot ===
ufw --force enable

