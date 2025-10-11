# QR Menu Generator - Infrastructure

Terraform configuration for deploying QR Menu Generator on AWS.

## Architecture

```
Internet → Cloudflare → AWS EIP → EC2 Instance → Docker Containers
                                      ├── Frontend (React) - Port 80
                                      ├── Backend (Spring Boot) - Port 8080
                                      └── Database (PostgreSQL) - Port 5432
```

## Modules Used

- terraform-aws-modules/ec2-instance/aws - EC2 instance
- terraform-aws-modules/security-group/aws - Security groups  
- terraform-aws-modules/key-pair/aws - SSH key pairs

## Quick Start

1. Configure variables:
```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your domain and password
```

2. Deploy:
```bash
terraform init
terraform apply
```

3. Get SSH key and connect:
```bash
terraform output -raw private_key > qr-menu-key.pem
chmod 600 qr-menu-key.pem
ssh -i qr-menu-key.pem ubuntu@$(terraform output -raw elastic_ip)
```

4. Deploy application:
```bash
cd /opt/qr-menu/deployment
cp .env.template .env
# Edit .env with your settings
./deploy.sh
```

5. Configure Cloudflare DNS with the Elastic IP from terraform output

## Resources Created

- EC2 Instance (t3.small)
- Elastic IP
- Security Group
- SSH Key Pair

## Configuration

Environment file at `/opt/qr-menu/deployment/.env`:
```
APP_BASE_URL=https://your-domain.com
FRONTEND_URL=https://your-domain.com
DB_NAME=qr_menu_db
DB_USER=qr_menu_user
DB_PASSWORD=your-password
```

## Operations

```bash
# Check application status
docker-compose ps

# View logs  
docker-compose logs -f

# Update application
cd /opt/qr-menu/deployment && ./deploy.sh
```

## Costs (Testing)

- EC2 t3.small: ~$0.021/hour
- Storage: ~$0.80/month  
- Total: ~$15/month running 24/7

For testing: ~$0.69/day

**Important**: Run `terraform destroy` when done testing.

```bash
# Destroy everything
terraform destroy

# Or use the management script
./manage.sh
```

## Commands

```bash
terraform init          # Initialize
terraform plan          # Preview changes  
terraform apply         # Deploy
terraform destroy       # Cleanup
terraform output        # Show outputs

docker-compose ps       # Check services
docker-compose logs -f  # View logs
```