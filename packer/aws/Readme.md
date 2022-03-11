# AWS AMI

## Requirements

- [Get Packer](https://www.packer.io/downloads.html)
- [Packer docs](https://www.packer.io/docs/index.html)
- [AWS Cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- [AWS Access Key](https://aws.amazon.com/premiumsupport/knowledge-center/create-access-key/)

### IAM Policy for Packer

- _IAM user should have permissions similar to below enabled in an IAM Policy for `packer build` to run correctly_

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Packer",
      "Effect": "Allow",
      "Action": [
        "ec2:AttachVolume",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:CopyImage",
        "ec2:CreateImage",
        "ec2:CreateKeypair",
        "ec2:CreateSecurityGroup",
        "ec2:CreateSnapshot",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteKeypair",
        "ec2:DeleteSecurityGroup",
        "ec2:DeleteSnapshot",
        "ec2:DeleteVolume",
        "ec2:DeregisterImage",
        "ec2:DescribeImageAttribute",
        "ec2:DescribeImages",
        "ec2:DescribeInstances",
        "ec2:DescribeRegions",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSnapshots",
        "ec2:DescribeSubnets",
        "ec2:DescribeTags",
        "ec2:DescribeVolumes",
        "ec2:DetachVolume",
        "ec2:GetPasswordData",
        "ec2:ModifyImageAttribute",
        "ec2:ModifyInstanceAttribute",
        "ec2:RegisterImage",
        "ec2:RunInstances",
        "ec2:StopInstances",
        "ec2:TerminateInstances"
      ],
      "Resource": "*"
    }
  ]
}
```

## Build Automation with Packer

[Packer](https://www.packer.io/intro) is a tool for creating images from a single source configuration. Using this Packer template reduces the entire process of creating, configuring, validating, and snapshotting a build AMI to a single command:

```
packer build debian.json
```

## Usage

To run the stack in this template, you'll need to [install Packer](https://www.packer.io/intro/getting-started/install.html) and [create an AWS access key](https://aws.amazon.com/premiumsupport/knowledge-center/create-access-key/). Running `packer build debian.json` without any other modifications will create a build instance configured with [stacks-blockchain-docker](https://github.com/stacks-network/stacks-blockchain-docker), clean and verify it, then power it down and create an AMI.

To start adapting this template for your own image, you can customize some variables in `debian.json`:

- `apt_packages` lists the APT packages to install on the build instance.
- `application_version` defines the stacks-blockchain version
- `image_name` defines the name of the resulting snapshot, which by default is `stacks-blockchain-X.X.X.X` with a UNIX timestamp appended.

You can also modify these variables at runtime by using [the `-var` flag](https://www.packer.io/docs/templates/legacy_json_templates/user-variables#setting-variables).

`files` and `scripts` are provided here as symlinks to the root of the repo.

- [files](../../files)
- [scripts](../../scripts)

### Sample Output

A successful run would look like this output:

```bash
$ packer build debian.json
==> amazon-ebs: Prevalidating any provided VPC information
==> amazon-ebs: Prevalidating AMI Name: stacks-blockchain-2.05.0.1.0-1646875033
    amazon-ebs: Found Image ID: ami-01e444ea01a94963a
    amazon-ebs: Found VPC ID: vpc-27da155a
==> amazon-ebs: Creating temporary keypair: packer_6229519a-1b39-ff22-8b63-f181cada048f
==> amazon-ebs: Creating temporary security group for this instance: packer_6229519e-a255-6caa-f4f6-47c3a0a4c27a
==> amazon-ebs: Authorizing access to port 22 from [0.0.0.0/0] in the temporary security groups...
==> amazon-ebs: Launching a source AWS instance...
==> amazon-ebs: Adding tags to source instance
    amazon-ebs: Adding tag: "Name": "Packer Builder"
    amazon-ebs: Instance ID: i-0e637bf91efbded43
==> amazon-ebs: Waiting for instance (i-0e637bf91efbded43) to become ready...
==> amazon-ebs: Using SSH communicator to connect: 34.201.109.118
==> amazon-ebs: Waiting for SSH to become available...
    ... LINES OMITTED ...
==> amazon-ebs: Provisioning with shell script: scripts/01-docker.sh
    ... LINES OMITTED ...
==> amazon-ebs: Provisioning with shell script: scripts/02-ufw.sh
    ... LINES OMITTED ...
    amazon-ebs: ---------------------------------------------------------------------------------------------------
    amazon-ebs: Scan Complete.
    amazon-ebs: Some non-critical tests failed.  Please review these items.
    amazon-ebs: ---------------------------------------------------------------------------------------------------
    amazon-ebs: 8 Tests PASSED
    amazon-ebs: 1 WARNINGS
    amazon-ebs: 0 Tests FAILED
    amazon-ebs: ---------------------------------------------------------------------------------------------------
    amazon-ebs: Please review all [WARN] items above and ensure they are intended or resolved.  If you do not have a specific requirement, we recommend resolving these items before image submission
    amazon-ebs:
==> amazon-ebs: Stopping the source instance...
==> amazon-ebs: Creating AMI tags
    amazon-ebs: Adding tag: "Arch": "x86_64"
    amazon-ebs: Adding tag: "OS": "Debian 10"
    amazon-ebs: Adding tag: "Name": "Stacks-Blockchain"
    amazon-ebs: Adding tag: "BuildTime": "1646871474"
    amazon-ebs: Adding tag: "Version": "2.05.0.1.0"
==> amazon-ebs: Creating snapshot tags
==> amazon-ebs: Terminating the source AWS instance...
==> amazon-ebs: Cleaning up any extra volumes...
==> amazon-ebs: No volumes to clean up, skipping
==> amazon-ebs: Deleting temporary security group...
==> amazon-ebs: Deleting temporary keypair...
Build 'amazon-ebs' finished after 9 minutes 37 seconds.

==> Wait completed after 9 minutes 37 seconds

==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs: AMIs were created:
us-east-1: ami-0fce64ccd98800d8f
```
