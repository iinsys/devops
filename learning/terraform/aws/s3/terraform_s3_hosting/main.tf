terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
        }
    }
    required_version = ">= 1.2.0"
}

## Use modules for templating files developed by hashicorp
module "template_files" {
    source = "hashicorp/dir/template"
    base_dir = "${path.module}/web" 
}

provider "aws" {
    region     = var.aws_region
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
}

resource "aws_s3_bucket" "nb_hosting_bucket" {
    bucket = var.bucket_name
    
    # object_ownership = "ObjectWriter"  
}

resource "aws_s3_bucket_public_access_block" "nb_public_access_block" {
    bucket = aws_s3_bucket.nb_hosting_bucket.id

    block_public_acls       = false   # Allow public ACLs (not strictly necessary if not using ACLs)
    block_public_policy     = false   # Allow public policies
    ignore_public_acls      = false   # Do not ignore public ACLs (not needed if not using ACLs)
    restrict_public_buckets = false   # Do not restrict public buckets
}

resource "aws_s3_bucket_policy" "hosting_bucket_policy" {
    bucket = aws_s3_bucket.nb_hosting_bucket.id
    policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": "*",
                "Action": "s3:GetObject",
                "Resource": "arn:aws:s3:::${var.bucket_name}/*"
            }
        ]
    })
}

resource "aws_s3_bucket_website_configuration" "hosting_bucket_configuration" {
    bucket = aws_s3_bucket.nb_hosting_bucket.id

    index_document {
        suffix = "index.html"
    }
}

# AWS S3 object resource
resource "aws_s3_object" "hosting_bucket_files" {
    bucket = aws_s3_bucket.nb_hosting_bucket.id

    for_each = module.template_files.files

    key         = each.key
    content_type= each.value.content_type

    source      = each.value.source_path
    content     = each.value.content

    etag        = each.value.digests.md5
}