# Stacks Blockchain Image building tools

[![Apache license](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![Pull Requests Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat)](http://makeapullrequest.com)

This repository contains resources for creating a standalone instance of the [stacks-blockchain](https://github.com/stacks-network/stacks-blockchain) with postgres and the [stacks-blockchain-api](https://github.com/hirosystems/stacks-blockchain-api)

## Requirements

- [Get Packer](https://www.packer.io/downloads.html)
- [Packer docs](https://www.packer.io/docs/index.html)

## Supported Providers

⚠️ _PR's Welcome for other providers_

Common files used by all providers are located at the base of this repo, like [files](./files) and [scripts](./scripts).

Specific configurations for each provider are located under the [packer](./packer) directory, with providers each having their own folder, like `./packer/digitalocean`.

To start adapting these templates for your own image, you can customize some variables in `./packer/<provider>/debian.json`:

- `apt_packages` lists the APT packages to install on the build Droplet.
- `application_version` defines the stacks-blockchain version
- `image_name` defines the name of the resulting snapshot, which by default is `stacks-blockchain-X.X.X.X` with a UNIX timestamp appended.

You can also modify these variables at runtime by using [the `-var` flag](https://www.packer.io/docs/templates/legacy_json_templates/user-variables#setting-variables).

Note that the paths in the templates are set so that you'll need to invoke the `packer` command from the root of this repo.

The [scripts](./scripts) folder contains the scripts `packer` uses to setup the host.

1. [01-docker.sh](./scripts/01-docker.sh) - Installs Docker, docker-compose and required packages.
2. [02-stacks-blockchain.sh](./scripts/02-stacks-blockchain.sh) - Clones [stacks-blockchain-docker](https://github.com/stacks-network/stacks-blockchain-docker) and creates the [unit file](./files/etc/systemd/system/stacks.service).
3. [02-ufw.sh](./scripts/02-ufw.sh) - Configures simple Firewall.
4. [03-bns.sh](./scripts/03-bns.sh) - Downloads and extracts BNS data and enables the env var for the API.
5. [90-cleanup-no_dd.sh](./scripts/90-cleanup-no_dd.sh) - Cleans the built system/logs without zeroing the disk.
6. [90-cleanup.sh](./scripts/90-cleanup.sh) - Cleans the built system/logs and zeroes the disk.
7. [99-img-check.sh](./scripts/99-img-check.sh) - Checks the snapshot for any build artifacts.

By default, no extra env vars are enabled in the API - [defaults are used](https://github.com/stacks-network/stacks-blockchain-docker/blob/master/sample.env).

#### (Optional) Enable BNS data

In [03-bns.sh](./scripts/03-bns.sh), uncomment the following:

```
# echo "=== Enable stacks-blockchain-api BNS data ==="
# sed -i -e 's|# BNS_IMPORT_DIR|BNS_IMPORT_DIR|' /opt/stacks-blockchain-docker/.env

# echo "=== Downloading BNS Data ==="
# BNS_IMPORT_DIR="/opt/stacks-blockchain-docker/persistent-data/bns-data" /opt/stacks-blockchain-docker/scripts/setup-bns.sh

```

#### (Optional) Enable NFT/FT metadata

In [02-stacks-blockchain.sh](./scripts/02-stacks-blockchain.sh), uncomment the following:

```
# echo "=== Enable stacks-blockchain-api fungible metadata ==="
# sed -i -e 's|# STACKS_API_ENABLE_FT_METADATA|STACKS_API_ENABLE_FT_METADATA|' /opt/stacks-blockchain-docker/.env

# echo "=== Enable stacks-blockchain-api non-fungible metadata ==="
# sed -i -e 's|# STACKS_API_ENABLE_NFT_METADATA|STACKS_API_ENABLE_NFT_METADATA|' /opt/stacks-blockchain-docker/.env
```

### DigitalOcean

[Readme](./packer/digitalocean/Readme.md)

[Packer Template](./packer/digitalocean/debian.json)

```bash
$ packer build ./packer/digitalocean/debian.json
```

[Sample Output](./packer/digitalocean/Readme.md#sample-output)

### AWS

AWS template uses a slightly different cleanup script than DigitalOcean, specifically there is no `dd` to zero the disk before the image is created. With this included, the process frequently timed out.

[Readme](./packer/aws/Readme.md)

[Packer Template](./packer/aws/debian.json)

```bash
$ packer build ./packer/aws/debian.json
```

[Sample Output](./packer/aws/Readme.md#sample-output)
