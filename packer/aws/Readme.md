# AWS AMI

### Requirements

- [Get Packer](https://www.packer.io/downloads.html)
- [Packer docs](https://www.packer.io/docs/index.html)
- [AWS Cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- [AWS API Keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)

* IAM user should have the following permissions enabled in an IAM Policy for `packer build` to run correctly:

```
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
