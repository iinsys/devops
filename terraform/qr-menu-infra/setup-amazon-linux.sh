#!/bin/bash

# QR Menu Generator - Amazon Linux 2 Setup Script
# Fixed version for Amazon Linux 2 (uses yum instead of apt-get)

set -e

# Variables
PROJECT_NAME="qr-menu-test"
DOMAIN_NAME="qrmenu.noelbansikah.com"
DB_PASSWORD="admin@qrmenu"

# Log all output
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "Starting Amazon Linux 2 setup script execution at $(date)"

#################################
# System Updates & Basic Tools
#################################
echo "Updating system packages..."
sudo yum update -y

echo "Installing essential packages..."
sudo yum install -y \
    curl \
    wget \
    git \
    unzip \
    htop \
    tree \
    vim \
    yum-utils \
    device-mapper-persistent-data \
    lvm2

#################################
# Install Docker
#################################
echo "Installing Docker..."
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

echo "Docker installation completed"

#################################
# Install Docker Compose (standalone)
#################################
echo "Installing Docker Compose..."
COMPOSE_VERSION="v2.23.0"
sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Create symlink for docker-compose command
sudo ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose

echo "Docker Compose installation completed"

#################################
# Install AWS CLI (for potential future use)
#################################
echo "Installing AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip

#################################
# Create Application Directory
#################################
echo "Setting up application directory..."
sudo mkdir -p /opt/qr-menu
sudo chown -R ec2-user:ec2-user /opt/qr-menu
sudo chmod -R 755 /opt/qr-menu

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
APP_BASE_URL=https://${DOMAIN_NAME}
FRONTEND_URL=https://${DOMAIN_NAME}

# Database Configuration
DB_NAME=qr_menu_db
DB_USER=qr_menu_user
DB_PASSWORD=${DB_PASSWORD}

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
      POSTGRES_DB: ${DB_NAME:-qr_menu_db}
      POSTGRES_USER: ${DB_USER:-qr_menu_user} 
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    networks:
      - qr-menu-network
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${DB_USER:-qr_menu_user} -d ${DB_NAME:-qr_menu_db}"]
      interval: 30s
      timeout: 10s
      retries: 3

  backend:
    image: bansikah/qr-menu-backend:latest
    container_name: qr-menu-backend
    environment:
      SPRING_PROFILES_ACTIVE: ${SPRING_PROFILES_ACTIVE:-prod}
      SPRING_DATASOURCE_URL: jdbc:postgresql://postgres:5432/${DB_NAME:-qr_menu_db}
      SPRING_DATASOURCE_USERNAME: ${DB_USER:-qr_menu_user}
      SPRING_DATASOURCE_PASSWORD: ${DB_PASSWORD}
      APP_BASE_URL: ${APP_BASE_URL}
      FRONTEND_URL: ${FRONTEND_URL}
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
      VITE_API_BASE_URL: ${APP_BASE_URL}/api
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
set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="/opt/qr-menu/logs/deploy-$(date +%Y%m%d-%H%M%S).log"
ENV_FILE="${SCRIPT_DIR}/.env"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "Starting QR Menu Generator deployment..."

# Check if .env file exists
if [ ! -f "$ENV_FILE" ]; then
    log "ERROR: .env file not found at $ENV_FILE"
    log "Please create .env file from .env.template"
    exit 1
fi

# Load environment variables
source "$ENV_FILE"

# Change to deployment directory
cd "$SCRIPT_DIR"

# Pull latest images
log "Pulling latest Docker images..."
docker-compose pull

# Stop existing containers
log "Stopping existing containers..."
docker-compose down

# Start services
log "Starting services..."
docker-compose up -d

# Wait for services to be healthy
log "Waiting for services to be healthy..."
sleep 30

log "Deployment completed successfully!"
log "Application is available at: $APP_BASE_URL"

# Check service status
docker-compose ps
EOF

chmod +x /opt/qr-menu/deployment/deploy.sh

#################################
# Set Proper Ownership
#################################
echo "Setting proper ownership..."
sudo chown -R ec2-user:ec2-user /opt/qr-menu

echo "Amazon Linux 2 setup completed successfully!"
echo "Next steps:"
echo "1. Navigate to: cd /opt/qr-menu/deployment"
echo "2. Copy environment: cp .env.template .env"
echo "3. Edit .env with your values"
echo "4. Deploy application: ./deploy.sh"
echo ""
echo "Setup script completed at $(date)"