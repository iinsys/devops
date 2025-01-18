"""An AWS Python Pulumi program"""

import pulumi
from pulumi_aws import s3, ec2

# Create an AWS resource (S3 Bucket)
bucket = s3.BucketV2('my-bucket')

# Export the name of the bucket
pulumi.export('bucket_name', bucket.id)

# Create security groups
sg = ec2.SecurityGroup('web-secgrp', description='Web server security group')

# Create an AWS resource (EC2 Instance)
ec2_instance = ec2.Instance('web-server',
                            
    instance_type='t2.micro',
    ami='ami-09042b2f6d07d164a',
    key_name='my-key-pair',
    vpc_security_group_ids=[sg.id],
    tags={
        'Name': 'web-server'
    })

allow_ssh = ec2.SecurityGroupRule('allow-ssh',
    type='ingress',
    from_port=22,
    to_port=22,
    protocol='tcp',
    cidr_blocks=['0.0.0.0/0'],
    security_group_id=sg.id)

allow_http = ec2.SecurityGroupRule('allow-http',
    type='ingress',
    from_port=80,
    to_port=80,
    protocol='tcp',
    cidr_blocks=['0.0.0.0/0'],
    security_group_id=sg.id)

allow_all = ec2.SecurityGroupRule('allow-all',
    type='egress',
    from_port=0,
    to_port=0,
    protocol="-1",
    cidr_blocks=['0.0.0.0/0'],
    security_group_id=sg.id)

# Associate the security group with the EC2 instance
#ec2_instance.vpc_security_group_ids = [sg.id]

# Export the public IP address of the EC2 instance
pulumi.export('ec2_public_ip', ec2_instance.public_ip)