# DigitalOcean Droplet

For more information, see the [DigitalOcean Source Repo](https://github.com/digitalocean/marketplace-partners)

## Requirements

- [Get Packer](https://www.packer.io/downloads.html)
- [Packer docs](https://www.packer.io/docs/index.html)

## Build Automation with Packer

[Packer](https://www.packer.io/intro) is a tool for creating images from a single source configuration. Using this Packer template reduces the entire process of creating, configuring, validating, and snapshotting a build AMI to a single command:

```
packer build debian.json
```

## Usage

To run the stack in this template, you'll need to [install Packer](https://www.packer.io/intro/getting-started/install.html) and [create a DigitalOcean personal access token](https://docs.digitalocean.com/reference/api/create-personal-access-token/) and set it to the `DIGITALOCEAN_TOKEN` environment variable. Running `packer build debian.json` without any other modifications will create a build Droplet configured with [stacks-blockchain-docker](https://github.com/stacks-network/stacks-blockchain-docker), clean and verify it, then power it down and snapshot it.

To start adapting this template for your own image, you can customize some variables in `debian.json`:

- `apt_packages` lists the APT packages to install on the build Droplet.
- `application_version` defines the stacks-blockchain version
- `image_name` defines the name of the resulting snapshot, which by default is `stacks-blockchain-X.X.X.X` with a UNIX timestamp appended.

You can also modify these variables at runtime by using [the `-var` flag](https://www.packer.io/docs/templates/legacy_json_templates/user-variables#setting-variables).

A successful run would look like this output:

`files` and `scripts` are provided here as symlinks to the root of the repo.

- [files](../../files)
- [scripts](../../scripts)

### Sample Output

A successful run would look like this output:

```bash
$ packer build debian.json
digitalocean: output will be in this color.

==> digitalocean: Creating temporary RSA SSH key for instance...
==> digitalocean: Importing SSH public key...
==> digitalocean: Creating droplet...
==> digitalocean: Waiting for droplet to become active...
==> digitalocean: Using SSH communicator to connect: 167.172.30.59
==> digitalocean: Waiting for SSH to become available...
    ... LINES OMITTED ...
==> digitalocean: Provisioning with shell script: scripts/01-docker.sh
    ... LINES OMITTED ...
==> digitalocean: Provisioning with shell script: scripts/02-stacks-blockchain.sh
    ... LINES OMITTED ...
==> digitalocean: Provisioning with shell script: scripts/02-ufw.sh
    ... LINES OMITTED ...
==> digitalocean: Provisioning with shell script: scripts/90-cleanup.sh
    ... LINES OMITTED ...
    digitalocean: Writing zeros to the remaining disk space to securely
    digitalocean: erase the unused portion of the file system.
    digitalocean: Depending on your disk size this may take several minutes.
    digitalocean: The secure erase will complete successfully when you see:
    digitalocean:     dd: writing to '/zerofile': No space left on device
    digitalocean:
    digitalocean: Beginning secure erase now
==> digitalocean: dd: error writing '/zerofile': No space left on device
==> digitalocean: 20193671+0 records in
==> digitalocean: 20193670+0 records out
==> digitalocean: 82713272320 bytes (83 GB, 77 GiB) copied, 216.76 s, 382 MB/s
==> digitalocean: Provisioning with shell script: scripts/99-img-check.sh
==> digitalocean: TERM environment variable not set.
    ... LINES OMITTED ...
    digitalocean: ---------------------------------------------------------------------------------------------------
    digitalocean: Scan Complete.
    digitalocean: Some non-critical tests failed.  Please review these items.
    digitalocean: ---------------------------------------------------------------------------------------------------
    digitalocean: 7 Tests PASSED
    digitalocean: 3 WARNINGS
    digitalocean: 0 Tests FAILED
    digitalocean: ---------------------------------------------------------------------------------------------------
    digitalocean: Please review all [WARN] items above and ensure they are intended or resolved.  If you do not have a specific requirement, we recommend resolving these items before image submission
    digitalocean:
==> digitalocean: Gracefully shutting down droplet...
==> digitalocean: Creating snapshot: stacks-blockchain-2.05.0.1.0-1646870774
==> digitalocean: Waiting for snapshot to complete...
==> digitalocean: Destroying droplet...
==> digitalocean: Deleting temporary ssh key...
Build 'digitalocean' finished after 14 minutes 45 seconds.

==> Wait completed after 14 minutes 45 seconds

==> Builds finished. The artifacts of successful builds are:
--> digitalocean: A snapshot was created: 'stacks-blockchain-2.05.0.1.0-1646870774' (ID: 103642716) in regions 'nyc3'
```
