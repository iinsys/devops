# QR Menu Generator Infrastructure - Using Community Modules
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Application = "qr-menu-generator"
    }
  }
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default subnets
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}



#################################
# Security Group Module
#################################
module "security_group" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${var.project_name}-sg"
  description = "Security group for QR Menu Generator application"
  vpc_id      = data.aws_vpc.default.id

  # Ingress rules
  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = var.allowed_ssh_cidr
      description = "SSH access"
    },
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "HTTP access"
    },
    {
      rule        = "https-443-tcp" 
      cidr_blocks = "0.0.0.0/0"
      description = "HTTPS access"
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = var.allowed_ssh_cidr
      description = "Backend API access"
    }
  ]

  # Egress rules
  egress_rules = ["all-all"]

  tags = local.common_tags
}

#################################
# Key Pair Module
#################################
module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"
  version = "~> 2.0"

  key_name           = var.key_name
  create_private_key = var.create_private_key
  public_key         = var.create_private_key ? null : file("${path.module}/${var.public_key_path}")

  tags = local.common_tags
}

#################################
# EC2 Instance Module
#################################
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name = "${var.project_name}-server"

  # Instance configuration
  instance_type               = var.instance_type
  key_name                   = module.key_pair.key_pair_name
  monitoring                 = var.enable_monitoring
  vpc_security_group_ids     = [module.security_group.security_group_id]
  subnet_id                  = data.aws_subnets.default.ids[0]
  associate_public_ip_address = true

  # Storage
  create_iam_instance_profile = true
  iam_role_description        = "IAM role for QR Menu EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    CloudWatchAgentServerPolicy  = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  }

  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = var.root_volume_size
      encrypted   = true
    }
  ]

  volume_tags = {
    Name = "${var.project_name}-root-volume"
  }

  # User data for initial setup
  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    project_name = var.project_name
    domain_name  = var.domain_name
    db_password  = var.db_password
  }))

  tags = merge(local.common_tags, {
    Type = "application-server"
  })
}

#################################
# Elastic IP
#################################
resource "aws_eip" "this" {
  instance = module.ec2_instance.id
  domain   = "vpc"

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-eip"
  })

  depends_on = [module.ec2_instance]
}

