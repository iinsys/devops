# User Management for DevOps

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:
- Create and manage user accounts
- Configure sudo access and permissions
- Manage user groups and permissions
- Set up service accounts for applications
- Implement security best practices

## 👥 Why User Management Matters in DevOps

User management is crucial for:
- **Security**: Proper access control and permissions
- **Service Accounts**: Dedicated users for applications
- **Automation**: Scripted user creation and management
- **Compliance**: Audit trails and access logging

## 🔐 User Account Management

### Creating Users
```bash
# Create a new user
sudo useradd -m -s /bin/bash username

# Create user with specific UID
sudo useradd -m -u 1001 -s /bin/bash username

# Create user with home directory and shell
sudo useradd -m -d /home/username -s /bin/bash username

# Create system user (no login shell)
sudo useradd -r -s /bin/false serviceuser
```

### User Configuration
```bash
# Set password for user
sudo passwd username

# Lock/unlock user account
sudo usermod -L username  # Lock
sudo usermod -U username  # Unlock

# Change user shell
sudo usermod -s /bin/bash username

# Change user home directory
sudo usermod -d /new/home/path username

# Set account expiration
sudo usermod -e 2024-12-31 username
```

### User Information
```bash
# Show user information
id username

# Show all users
cat /etc/passwd

# Show user login history
last username

# Show current logged in users
who
w
```

## 🛡️ Sudo Configuration

### Basic Sudo Usage
```bash
# Run command as root
sudo command

# Switch to root user
sudo su -

# Run command as another user
sudo -u username command

# Edit file with sudo
sudo nano /etc/hosts

# Check sudo privileges
sudo -l
```

### Sudo Configuration File
```bash
# Edit sudoers file safely
sudo visudo

# Sudoers file syntax examples:
# /etc/sudoers

# Allow user to run all commands
username ALL=(ALL) ALL

# Allow user to run specific commands
username ALL=(ALL) /usr/bin/systemctl, /usr/bin/docker

# Allow user to run commands without password
username ALL=(ALL) NOPASSWD: ALL

# Allow group to run commands
%devops ALL=(ALL) ALL

# Allow user to run commands as specific user
username ALL=(www-data) /usr/bin/systemctl restart nginx
```

### Sudo Logging
```bash
# View sudo logs
sudo tail -f /var/log/auth.log

# Search for specific user sudo activity
grep "username" /var/log/auth.log | grep sudo

# Show sudo usage summary
sudo grep sudo /var/log/auth.log | awk '{print $1, $2, $3, $6}' | sort | uniq -c
```

## 👥 Group Management

### Creating and Managing Groups
```bash
# Create a new group
sudo groupadd groupname

# Create group with specific GID
sudo groupadd -g 1001 groupname

# Add user to group
sudo usermod -aG groupname username

# Remove user from group
sudo gpasswd -d username groupname

# Show group information
getent group groupname

# Show all groups
cat /etc/group

# Show user's groups
groups username
id username
```

### Common DevOps Groups
```bash
# Create DevOps groups
sudo groupadd devops
sudo groupadd docker
sudo groupadd developers

# Add users to groups
sudo usermod -aG devops username
sudo usermod -aG docker username
sudo usermod -aG developers username
```

## 🔧 Service Accounts

### Creating Service Accounts
```bash
# Create service account for nginx
sudo useradd -r -s /bin/false -d /var/lib/nginx nginx

# Create service account for application
sudo useradd -r -s /bin/false -d /opt/myapp -c "MyApp Service User" myapp

# Set ownership of application files
sudo chown -R myapp:myapp /opt/myapp

# Set appropriate permissions
sudo chmod -R 755 /opt/myapp
```

### Service Account Best Practices
```bash
# Service accounts should:
# 1. Have no login shell (/bin/false or /usr/sbin/nologin)
# 2. Have dedicated home directories
# 3. Have minimal permissions
# 4. Be used only for specific services

# Example: Create database service account
sudo useradd -r -s /bin/false -d /var/lib/mysql -c "MySQL Server" mysql
sudo chown -R mysql:mysql /var/lib/mysql
sudo chmod 700 /var/lib/mysql
```

## 📝 Hands-on Exercises

### Exercise 1: User Creation and Management
```bash
# Create a new user for development
sudo useradd -m -s /bin/bash -c "Developer User" devuser
sudo passwd devuser

# Add user to sudo group
sudo usermod -aG sudo devuser

# Verify user creation
id devuser
groups devuser

# Test sudo access
sudo -u devuser sudo -l
```

### Exercise 2: Group Management
```bash
# Create development groups
sudo groupadd developers
sudo groupadd testers

# Add users to groups
sudo usermod -aG developers devuser
sudo usermod -aG testers devuser

# Create shared directory
sudo mkdir -p /opt/shared
sudo chown root:developers /opt/shared
sudo chmod 775 /opt/shared

# Test group access
sudo -u devuser touch /opt/shared/test.txt
```

### Exercise 3: Service Account Setup
```bash
# Create service account for web application
sudo useradd -r -s /bin/false -d /opt/webapp -c "Web App Service" webapp

# Create application directory
sudo mkdir -p /opt/webapp/{logs,data,config}
sudo chown -R webapp:webapp /opt/webapp
sudo chmod -R 755 /opt/webapp

# Create systemd service file
sudo tee /etc/systemd/system/webapp.service > /dev/null << EOF
[Unit]
Description=Web Application
After=network.target

[Service]
Type=simple
User=webapp
Group=webapp
WorkingDirectory=/opt/webapp
ExecStart=/opt/webapp/app
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and enable service
sudo systemctl daemon-reload
sudo systemctl enable webapp
```

## 🎯 DevOps Scenarios

### Scenario 1: Automated User Provisioning
```bash
#!/bin/bash
# provision_user.sh - Automated user creation

USERNAME="$1"
GROUPS="$2"
SSH_KEY="$3"

if [[ -z "$USERNAME" ]]; then
    echo "Usage: $0 <username> [groups] [ssh_key]"
    exit 1
fi

# Create user
echo "Creating user: $USERNAME"
sudo useradd -m -s /bin/bash "$USERNAME"

# Set random password
PASSWORD=$(openssl rand -base64 12)
echo "$USERNAME:$PASSWORD" | sudo chpasswd

# Add to groups
if [[ -n "$GROUPS" ]]; then
    IFS=',' read -ra GROUP_ARRAY <<< "$GROUPS"
    for group in "${GROUP_ARRAY[@]}"; do
        sudo usermod -aG "$group" "$USERNAME"
    done
fi

# Add SSH key
if [[ -n "$SSH_KEY" ]]; then
    sudo mkdir -p "/home/$USERNAME/.ssh"
    echo "$SSH_KEY" | sudo tee "/home/$USERNAME/.ssh/authorized_keys" > /dev/null
    sudo chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.ssh"
    sudo chmod 700 "/home/$USERNAME/.ssh"
    sudo chmod 600 "/home/$USERNAME/.ssh/authorized_keys"
fi

echo "✅ User $USERNAME created successfully"
echo "Password: $PASSWORD"
```

### Scenario 2: Sudo Access Management
```bash
#!/bin/bash
# manage_sudo_access.sh

USERNAME="$1"
ACTION="$2"  # grant, revoke, list

if [[ -z "$USERNAME" || -z "$ACTION" ]]; then
    echo "Usage: $0 <username> <grant|revoke|list>"
    exit 1
fi

case "$ACTION" in
    "grant")
        echo "Granting sudo access to $USERNAME"
        echo "$USERNAME ALL=(ALL) ALL" | sudo tee -a /etc/sudoers.d/$USERNAME
        sudo chmod 440 /etc/sudoers.d/$USERNAME
        ;;
    "revoke")
        echo "Revoking sudo access from $USERNAME"
        sudo rm -f /etc/sudoers.d/$USERNAME
        ;;
    "list")
        echo "Sudo access for $USERNAME:"
        sudo -l -U "$USERNAME"
        ;;
    *)
        echo "Invalid action: $ACTION"
        exit 1
        ;;
esac
```

### Scenario 3: User Audit Script
```bash
#!/bin/bash
# user_audit.sh - Security audit of user accounts

echo "=== User Security Audit ==="
echo "Date: $(date)"
echo ""

# Check for users with no password
echo "Users with no password:"
sudo awk -F: '($2 == "") {print $1}' /etc/shadow

# Check for users with UID 0 (root)
echo ""
echo "Users with UID 0:"
awk -F: '($3 == 0) {print $1}' /etc/passwd

# Check for users with shell access
echo ""
echo "Users with shell access:"
awk -F: '($7 != "/bin/false" && $7 != "/usr/sbin/nologin") {print $1, $7}' /etc/passwd

# Check sudo access
echo ""
echo "Users with sudo access:"
sudo grep -E '^[^#].*ALL.*ALL' /etc/sudoers /etc/sudoers.d/* 2>/dev/null | awk '{print $1}'

# Check last login
echo ""
echo "Users who haven't logged in recently:"
lastlog | awk 'NR>1 && $2 == "**Never logged in**" {print $1}'
```

## 🔒 Security Best Practices

### Password Policies
```bash
# Install password quality module
sudo apt install libpam-pwquality  # Ubuntu/Debian
sudo yum install libpwquality      # CentOS/RHEL

# Configure password policy
sudo nano /etc/security/pwquality.conf

# Example configuration:
# minlen = 12
# dcredit = -1
# ucredit = -1
# lcredit = -1
# ocredit = -1
```

### Account Lockout
```bash
# Configure account lockout
sudo nano /etc/pam.d/common-auth

# Add these lines:
# auth required pam_tally2.so deny=5 onerr=fail unlock_time=1800
# account required pam_tally2.so
```

### SSH Key Management
```bash
# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -C "user@example.com"

# Copy public key to server
ssh-copy-id username@server

# Disable password authentication (in /etc/ssh/sshd_config)
# PasswordAuthentication no
# PubkeyAuthentication yes
```

## ✅ Check Your Understanding

1. How do you create a user without a login shell?
2. What's the difference between `useradd` and `adduser`?
3. How do you grant sudo access to a specific user?
4. What's the purpose of service accounts?
5. How do you audit user accounts for security?

## 🚀 Next Steps

Ready to learn about networking? Move on to [Networking](../networking/) to understand network configuration and troubleshooting.

---

> **💡 Remember**: Proper user management is essential for security. Always follow the principle of least privilege!
