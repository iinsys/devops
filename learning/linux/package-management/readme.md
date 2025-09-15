# Package Management for DevOps

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:
- Use apt/yum/dnf to install and manage packages
- Handle package repositories and GPG keys
- Install development tools and dependencies
- Manage package updates and security patches
- Troubleshoot package installation issues

## 📦 Why Package Management Matters in DevOps

Package management is essential for:
- **Environment Setup**: Installing tools and dependencies
- **Automation**: Scripting package installations
- **Security**: Managing updates and patches
- **Reproducibility**: Consistent environments across servers

## 🐧 Package Managers by Distribution

### Ubuntu/Debian - APT
```bash
# Update package lists
sudo apt update

# Upgrade installed packages
sudo apt upgrade

# Install package
sudo apt install package_name

# Remove package
sudo apt remove package_name

# Remove package and config files
sudo apt purge package_name

# Search for packages
apt search keyword

# Show package information
apt show package_name

# List installed packages
apt list --installed

# Clean package cache
sudo apt clean
sudo apt autoclean
```

### CentOS/RHEL/Rocky - YUM/DNF
```bash
# Update package lists
sudo yum update
sudo dnf update

# Install package
sudo yum install package_name
sudo dnf install package_name

# Remove package
sudo yum remove package_name
sudo dnf remove package_name

# Search for packages
yum search keyword
dnf search keyword

# Show package information
yum info package_name
dnf info package_name

# List installed packages
yum list installed
dnf list installed

# Clean package cache
sudo yum clean all
sudo dnf clean all
```

## 🛠️ Essential DevOps Packages

### Development Tools
```bash
# Ubuntu/Debian
sudo apt install -y \
    curl wget git vim nano \
    build-essential \
    python3 python3-pip \
    nodejs npm \
    docker.io docker-compose \
    jq tree htop

# CentOS/RHEL
sudo yum install -y \
    curl wget git vim nano \
    gcc gcc-c++ make \
    python3 python3-pip \
    nodejs npm \
    docker docker-compose \
    jq tree htop
```

### Monitoring and Logging
```bash
# Ubuntu/Debian
sudo apt install -y \
    htop iotop nethogs \
    rsyslog logrotate \
    tcpdump netstat-nat \
    strace ltrace

# CentOS/RHEL
sudo yum install -y \
    htop iotop nethogs \
    rsyslog logrotate \
    tcpdump \
    strace ltrace
```

### Cloud and Container Tools
```bash
# AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

## 🔐 Repository Management

### Adding Repositories
```bash
# Ubuntu/Debian - Add repository
echo "deb https://repo.example.com/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/example.list

# Add GPG key
wget -qO - https://repo.example.com/gpg.key | sudo apt-key add -

# Update package lists
sudo apt update

# CentOS/RHEL - Add repository
sudo yum-config-manager --add-repo https://repo.example.com/rhel/7/x86_64/

# Enable repository
sudo yum-config-manager --enable example-repo
```

### Repository Configuration Files
```bash
# Ubuntu/Debian repository format
# /etc/apt/sources.list
deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse

# CentOS/RHEL repository format
# /etc/yum.repos.d/example.repo
[example-repo]
name=Example Repository
baseurl=https://repo.example.com/rhel/$releasever/$basearch/
enabled=1
gpgcheck=1
gpgkey=https://repo.example.com/gpg.key
```

## 📝 Hands-on Exercises

### Exercise 1: Package Installation
```bash
# Install essential tools
sudo apt update
sudo apt install -y curl wget git vim htop tree

# Verify installations
which curl wget git vim htop tree

# Check versions
curl --version
git --version
vim --version
```

### Exercise 2: Repository Management
```bash
# Add Docker repository (Ubuntu)
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Verify Docker installation
sudo systemctl start docker
sudo docker --version
```

### Exercise 3: Package Information
```bash
# Show detailed package information
apt show nginx

# Show package files
dpkg -L nginx

# Show which package owns a file
dpkg -S /usr/bin/nginx

# Show package dependencies
apt-cache depends nginx

# Show reverse dependencies
apt-cache rdepends nginx
```

## 🎯 DevOps Scenarios

### Scenario 1: Environment Setup Script
```bash
#!/bin/bash
# setup_devops_environment.sh

set -e

echo "Setting up DevOps environment..."

# Update system
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install essential tools
echo "Installing essential tools..."
sudo apt install -y \
    curl wget git vim nano \
    build-essential \
    python3 python3-pip \
    nodejs npm \
    htop tree jq \
    unzip zip \
    tcpdump netstat-nat

# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Helm
echo "Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

echo "✅ DevOps environment setup completed!"
echo "Please log out and back in to use Docker without sudo"
```

### Scenario 2: Security Updates
```bash
#!/bin/bash
# security_update.sh

echo "Checking for security updates..."

# Ubuntu/Debian
if command -v apt > /dev/null; then
    echo "Updating package lists..."
    sudo apt update
    
    echo "Checking for security updates..."
    sudo apt list --upgradable | grep -i security
    
    echo "Installing security updates..."
    sudo apt upgrade -y
    
    echo "Cleaning up..."
    sudo apt autoremove -y
    sudo apt autoclean
fi

# CentOS/RHEL
if command -v yum > /dev/null; then
    echo "Checking for security updates..."
    sudo yum check-update --security
    
    echo "Installing security updates..."
    sudo yum update --security -y
    
    echo "Cleaning up..."
    sudo yum clean all
fi

echo "✅ Security updates completed!"
```

### Scenario 3: Package Dependency Check
```bash
#!/bin/bash
# check_dependencies.sh

PACKAGE="$1"

if [[ -z "$PACKAGE" ]]; then
    echo "Usage: $0 <package_name>"
    exit 1
fi

echo "=== Dependency Analysis for $PACKAGE ==="

# Check if package is installed
if dpkg -l | grep -q "^ii.*$PACKAGE"; then
    echo "✅ Package is installed"
else
    echo "❌ Package is not installed"
    exit 1
fi

# Show dependencies
echo ""
echo "Dependencies:"
apt-cache depends "$PACKAGE" | grep "Depends:"

# Show reverse dependencies
echo ""
echo "Packages that depend on $PACKAGE:"
apt-cache rdepends "$PACKAGE" | grep -v "Reverse Depends:"

# Show package files
echo ""
echo "Package files:"
dpkg -L "$PACKAGE" | head -10
echo "... (showing first 10 files)"
```

## 🔧 Troubleshooting Package Issues

### Common Issues and Solutions:

1. **Broken Dependencies**
   ```bash
   # Fix broken dependencies
   sudo apt --fix-broken install
   
   # Or for CentOS/RHEL
   sudo yum-complete-transaction
   ```

2. **Package Lock Issues**
   ```bash
   # Remove package lock
   sudo rm /var/lib/dpkg/lock-frontend
   sudo rm /var/lib/dpkg/lock
   sudo rm /var/cache/apt/archives/lock
   
   # Reconfigure dpkg
   sudo dpkg --configure -a
   ```

3. **Repository Issues**
   ```bash
   # Clear package cache
   sudo apt clean
   sudo apt update
   
   # Remove problematic repository
   sudo rm /etc/apt/sources.list.d/problematic-repo.list
   sudo apt update
   ```

4. **GPG Key Issues**
   ```bash
   # Update GPG keys
   sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys KEY_ID
   
   # Or for newer systems
   wget -qO - https://repo.example.com/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/example-archive-keyring.gpg
   ```

## 💡 Best Practices

1. **Always Update**: Keep package lists updated
2. **Security First**: Prioritize security updates
3. **Documentation**: Keep track of installed packages
4. **Automation**: Use scripts for consistent installations
5. **Testing**: Test updates in staging before production

## ✅ Check Your Understanding

1. What's the difference between `apt remove` and `apt purge`?
2. How do you add a new repository to your system?
3. What command shows package dependencies?
4. How do you fix broken package dependencies?
5. How do you clean up unused packages?

## 🚀 Next Steps

Ready to learn about shell scripting? Move on to [Shell Scripting](../shell-scripting/) to automate package management and other DevOps tasks.

---

> **💡 Remember**: Package management is the foundation of system administration. Master these commands for efficient environment setup and maintenance!
