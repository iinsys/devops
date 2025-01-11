provider "aws" {
  region = var.region
}

terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
        
       kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
        helm = {
            source = "hashicorp/helm"
            version = ">=2.6.0"
        }
    }
    required_version = "~> 1.0"
}