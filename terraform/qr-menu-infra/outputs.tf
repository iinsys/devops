# Output Values for QR Menu Infrastructure

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2_instance.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_eip.this.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.ec2_instance.private_ip
}

output "elastic_ip" {
  description = "Elastic IP address"
  value       = aws_eip.this.public_ip
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.security_group.security_group_id
}

output "key_pair_name" {
  description = "Name of the key pair"
  value       = module.key_pair.key_pair_name
}

output "private_key" {
  description = "Private key content (only if create_private_key = true)"
  value       = var.create_private_key ? module.key_pair.private_key_pem : "Using existing public key"
  sensitive   = true
}

output "ssh_connection_command" {
  description = "SSH command to connect to the instance"
  value       = var.create_private_key ? "ssh -i ${var.key_name}.pem ubuntu@${aws_eip.this.public_ip}" : "ssh -i ~/.ssh/${var.key_name} ubuntu@${aws_eip.this.public_ip}"
}

output "application_urls" {
  description = "Application access URLs"
  value = {
    frontend = "https://${var.domain_name}"
    backend  = "https://${var.domain_name}/api"
    health   = "https://${var.domain_name}/api/actuator/health"
  }
}

output "cloudflare_dns_records" {
  description = "DNS records to configure in Cloudflare"
  value = {
    type    = "A"
    name    = "@"  # or "qrmenu" for subdomain
    content = aws_eip.this.public_ip
    proxied = true
  }
}

output "security_group_rules" {
  description = "Applied security group rules"
  value = {
    ssh_access   = "Port 22 - ${var.allowed_ssh_cidr}"
    http_access  = "Port 80 - 0.0.0.0/0"
    https_access = "Port 443 - 0.0.0.0/0"
    api_access   = "Port 8080 - ${var.allowed_ssh_cidr}"
    note         = "Update allowed_ssh_cidr in terraform.tfvars for better security"
  }
}

output "instance_details" {
  description = "EC2 instance details"
  value = {
    instance_type = var.instance_type
    volume_size   = "${var.root_volume_size}GB"
  }
}



output "deployment_commands" {
  description = "Commands to run after infrastructure is ready"
  value = {
    connect = var.create_private_key ? "ssh -i ${var.key_name}.pem ubuntu@${aws_eip.this.public_ip}" : "ssh -i ~/.ssh/${var.key_name} ubuntu@${aws_eip.this.public_ip}"
    deploy  = "cd /opt/qr-menu/deployment && ./deploy.sh"
    status  = "docker-compose ps"
    logs    = "docker-compose logs -f"
  }
}

output "cost_estimation" {
  description = "Estimated monthly costs (USD)"
  value = {
    ec2_instance = "~$15.12 (t3.small 24/7)"
    ebs_storage  = "~$0.80 (10GB gp3)"
    elastic_ip   = "~$3.65 (when not attached)"
    data_transfer = "~$0.45 (5GB/month)"
    total_estimated = "~$20.02/month"
    note = "Costs are estimates for testing - destroy when done!"
  }
}