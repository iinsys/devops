#!/bin/bash

# QR Menu Generator - EC2 User Data Script
# Automatically sets up the server with Docker and application dependencies

set -e

# Variables from Terraform
PROJECT_NAME="${project_name}"
DOMAIN_NAME="${domain_name}"
DB_PASSWORD="${db_password}"

# Log all output
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "Starting user-data script execution at $(date)"

#################################
# System Updates & Basic Tools
#################################
echo "Updating system packages..."
apt-get update
apt-get upgrade -y

echo "Installing essential packages..."
apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    htop \
    tree \
    vim \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release

#################################
# Install Docker
#################################
echo "Installing Docker..."
# Remove any old Docker versions
apt-get remove -y docker docker-engine docker.io containerd runc || true

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index and install Docker Engine
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Start and enable Docker
systemctl start docker
systemctl enable docker

echo "Docker installation completed"

#################################
# Install Docker Compose (standalone)
#################################
echo "Installing Docker Compose..."
COMPOSE_VERSION="v2.23.0"
curl -L "https://github.com/docker/compose/releases/download/$${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create symlink for docker-compose command
ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose

echo "Docker Compose installation completed"

#################################
# Install AWS CLI (for potential future use)
#################################
echo "Installing AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf aws awscliv2.zip

#################################
# Configure Firewall (UFW)
#################################
echo "Configuring firewall..."
ufw --force enable
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 8080/tcp  # Backend API for initial setup

echo "Firewall configuration completed"

#################################
# Create Application Directory
#################################
echo "Setting up application directory..."
mkdir -p /opt/qr-menu
chown -R ubuntu:ubuntu /opt/qr-menu
chmod -R 755 /opt/qr-menu

# Create deployment directory structure
mkdir -p /opt/qr-menu/deployment
mkdir -p /opt/qr-menu/logs
mkdir -p /opt/qr-menu/backups

#################################
# Create Environment File Template
#################################
echo "Creating environment file template..."
cat > /opt/qr-menu/deployment/.env.template << EOF
# QR Menu Generator - Production Environment Configuration
# Copy this to .env and update values for your domain

# Application URLs - Update with your domain
APP_BASE_URL=https://$${DOMAIN_NAME}
FRONTEND_URL=https://$${DOMAIN_NAME}

# Database Configuration
DB_NAME=qr_menu_db
DB_USER=qr_menu_user
DB_PASSWORD=$${DB_PASSWORD}

# Spring Configuration
SPRING_PROFILES_ACTIVE=prod

# Optional: Additional settings
JAVA_OPTS=-Xmx1g -Xms512m
EOF

#################################
# Create Docker Compose File
#################################
echo "Creating Docker Compose configuration..."
cat > /opt/qr-menu/deployment/docker-compose.yml << 'EOF'
services:
  postgres:
    image: postgres:15-alpine
    container_name: qr-menu-postgres
    environment:
      POSTGRES_DB: $${DB_NAME:-qr_menu_db}
      POSTGRES_USER: $${DB_USER:-qr_menu_user} 
      POSTGRES_PASSWORD: $${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    networks:
      - qr-menu-network
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U $${DB_USER:-qr_menu_user} -d $${DB_NAME:-qr_menu_db}"]
      interval: 30s
      timeout: 10s
      retries: 3

  backend:
    image: bansikah/qr-menu-backend:latest
    container_name: qr-menu-backend
    environment:
      SPRING_PROFILES_ACTIVE: $${SPRING_PROFILES_ACTIVE:-prod}
      SPRING_DATASOURCE_URL: jdbc:postgresql://postgres:5432/$${DB_NAME:-qr_menu_db}
      SPRING_DATASOURCE_USERNAME: $${DB_USER:-qr_menu_user}
      SPRING_DATASOURCE_PASSWORD: $${DB_PASSWORD}
      APP_BASE_URL: $${APP_BASE_URL}
      FRONTEND_URL: $${FRONTEND_URL}
      SERVER_PORT: 8080
    ports:
      - "8080:8080"
    networks:
      - qr-menu-network
    depends_on:
      postgres:
        condition: service_healthy
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/actuator/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  frontend:
    image: bansikah/qr-menu-frontend:latest
    container_name: qr-menu-frontend
    environment:
      VITE_API_BASE_URL: $${APP_BASE_URL}/api
    ports:
      - "80:80"
    networks:
      - qr-menu-network
    depends_on:
      backend:
        condition: service_healthy
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:80"]
      interval: 30s
      timeout: 10s
      retries: 3

volumes:
  postgres_data:
    driver: local

networks:
  qr-menu-network:
    driver: bridge
EOF

#################################
# Create Deployment Script
#################################
echo "Creating deployment script..."
cat > /opt/qr-menu/deployment/deploy.sh << 'EOF'
#!/bin/bash

# QR Menu Generator Production Deployment Script
# Enhanced version with better error handling and logging

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "$${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="/opt/qr-menu/logs/deploy-$(date +%Y%m%d-%H%M%S).log"
ENV_FILE="$${SCRIPT_DIR}/.env"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "Starting QR Menu Generator deployment..."

# Check if .env file exists
if [ ! -f "$ENV_FILE" ]; then
    log "ERROR: .env file not found at $ENV_FILE"
    log "Please create .env file from .env.template with your production values"
    log "Required variables: DB_PASSWORD, APP_BASE_URL, FRONTEND_URL"
    exit 1
fi

# Load environment variables
source "$ENV_FILE"

# Validate required environment variables
required_vars=("DB_PASSWORD" "APP_BASE_URL" "FRONTEND_URL")
for var in "$${required_vars[@]}"; do
    if [ -z "$${!var}" ]; then
        log "ERROR: $var is not set in .env file"
        exit 1
    fi
done

log "Environment variables validated successfully"

# Change to deployment directory
cd "$SCRIPT_DIR"

# Pull latest images
log "Pulling latest Docker images..."
docker-compose pull

# Create backup of current database (if exists)
if docker-compose ps postgres | grep -q "Up"; then
    log "Creating database backup..."
    mkdir -p /opt/qr-menu/backups
    docker-compose exec -T postgres pg_dump -U "$${DB_USER}" "$${DB_NAME}" > "/opt/qr-menu/backups/backup-$(date +%Y%m%d-%H%M%S).sql" || log "Warning: Could not create database backup"
fi

# Stop existing containers
log "Stopping existing containers..."
docker-compose down

# Start services
log "Starting services..."
docker-compose up -d

# Wait for services to be healthy
log "Waiting for services to be healthy..."
sleep 30

# Health check
log "Performing health checks..."
for i in {1..10}; do
    if curl -f http://localhost/health >/dev/null 2>&1 && curl -f http://localhost:8080/actuator/health >/dev/null 2>&1; then
        log "All services are healthy!"
        break
    fi
    log "Health check attempt $i/10 failed, waiting 10 seconds..."
    sleep 10
    if [ $i -eq 10 ]; then
        log "ERROR: Services failed health check after 10 attempts"
        docker-compose logs
        exit 1
    fi
done

# Check service status
log "Checking service status..."
docker-compose ps

log "Deployment completed successfully!"
log "Application is available at: $APP_BASE_URL"
log "Backend API health: $APP_BASE_URL/api/actuator/health"

# Cleanup old backups (keep only last 5)
find /opt/qr-menu/backups -name "backup-*.sql" -type f | sort -r | tail -n +6 | xargs -r rm

log "Deployment script completed"
EOF

# Make scripts executable
chmod +x /opt/qr-menu/deployment/deploy.sh

#################################
# Create System Monitoring Script
#################################
echo "Creating monitoring script..."
cat > /opt/qr-menu/monitor.sh << 'EOF'
#!/bin/bash

# Simple monitoring script for QR Menu application
echo "=== QR Menu System Status ==="
echo "Date: $(date)"
echo ""

echo "=== Docker Services ==="
cd /opt/qr-menu/deployment
docker-compose ps

echo ""
echo "=== System Resources ==="
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print $2 $3 $4 $5}'

echo ""
echo "Memory Usage:"
free -m

echo ""
echo "Disk Usage:"
df -h /

echo ""
echo "=== Application Health ==="
echo "Frontend Health:"
curl -s -o /dev/null -w "%%{http_code}" http://localhost/ || echo "Failed"

echo ""
echo "Backend Health:"
curl -s -o /dev/null -w "%%{http_code}" http://localhost:8080/actuator/health || echo "Failed"

echo ""
echo "=== Recent Logs (last 10 lines) ==="
docker-compose logs --tail=10
EOF

chmod +x /opt/qr-menu/monitor.sh

#################################
# Set Proper Ownership
#################################
echo "Setting proper ownership..."
chown -R ubuntu:ubuntu /opt/qr-menu

#################################
# Create Systemd Service (Optional)
#################################
echo "Creating systemd service for auto-start..."
cat > /etc/systemd/system/qr-menu.service << EOF
[Unit]
Description=QR Menu Generator Application
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
User=ubuntu
Group=ubuntu
WorkingDirectory=/opt/qr-menu/deployment
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
# Note: Don't enable the service yet - let user deploy manually first

#################################
# Configure Automatic Updates
#################################
echo "Configuring automatic security updates..."
apt-get install -y unattended-upgrades
cat > /etc/apt/apt.conf.d/20auto-upgrades << EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
EOF

#################################
# Install Nginx (for potential reverse proxy setup)
#################################
echo "Installing Nginx..."
apt-get install -y nginx
systemctl stop nginx  # Don't start it yet - Docker containers will handle ports
systemctl disable nginx

#################################
# Final Message
#################################
echo "Server setup completed successfully!"
echo "Next steps:"
echo "1. SSH to the server: ssh -i your-key.pem ubuntu@$(curl -s http://checkip.amazonaws.com)"
echo "2. Navigate to: cd /opt/qr-menu/deployment"
echo "3. Copy environment: cp .env.template .env"
echo "4. Edit .env with your values: nano .env"
echo "5. Deploy application: ./deploy.sh"
echo ""
echo "Files created:"
echo "  - /opt/qr-menu/deployment/docker-compose.yml"
echo "  - /opt/qr-menu/deployment/.env.template"
echo "  - /opt/qr-menu/deployment/deploy.sh"
echo "  - /opt/qr-menu/monitor.sh"
echo ""
echo "User data script completed at $(date)"