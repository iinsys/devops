# Input Variables for QR Menu Infrastructure

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Name of the project (used for resource naming)"
  type        = string
  default     = "qr-menu"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "production"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"  # Changed to t3.small for testing (cheaper than t3.medium)
  
  validation {
    condition = contains([
      "t3.micro", "t3.small", "t3.medium", "t3.large",
      "t2.micro", "t2.small", "t2.medium", "t2.large"
    ], var.instance_type)
    error_message = "Instance type must be a valid t2/t3 instance type."
  }
}

variable "root_volume_size" {
  description = "Size of the root EBS volume in GB"
  type        = number
  default     = 10  # Reduced from 20GB to 10GB for testing
  
  validation {
    condition     = var.root_volume_size >= 8 && var.root_volume_size <= 100
    error_message = "Root volume size must be between 8 and 100 GB."
  }
}

variable "key_name" {
  description = "Name of the AWS key pair for EC2 access"
  type        = string
  default     = "qr-menu-key"
}

variable "create_private_key" {
  description = "Create a new private key pair (true) or use existing public key (false)"
  type        = bool
  default     = true
}

variable "public_key_path" {
  description = "Path to the public key file (only used if create_private_key = false)"
  type        = string
  default     = "qr-menu-key.pub"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed for SSH access (your IP/32)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "db_password" {
  description = "Database password for PostgreSQL"
  type        = string
  sensitive   = true
  default     = "changeme123!"
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = "qrmenu.noelbansikah.com"
}

variable "log_retention_days" {
  description = "Number of days to retain CloudWatch logs"
  type        = number
  default     = 1  # Reduced from 7 to 1 day for testing
  
  validation {
    condition = contains([
      1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653
    ], var.log_retention_days)
    error_message = "Log retention must be a valid CloudWatch retention period."
  }
}

variable "enable_monitoring" {
  description = "Enable detailed monitoring for EC2 instance"
  type        = bool
  default     = false  # Disabled detailed monitoring for testing (saves cost)
}

variable "backup_retention_days" {
  description = "Number of days to retain automated backups"
  type        = number
  default     = 7
}

variable "application_port" {
  description = "Port where the application backend runs"
  type        = number
  default     = 8080
}

variable "database_port" {
  description = "Port where PostgreSQL runs"
  type        = number
  default     = 5432
}