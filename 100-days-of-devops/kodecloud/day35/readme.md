Day 35: Install Docker Packages and Start Docker Service

>You are exactly where you need to be. You are not behind.

The Nautilus DevOps team aims to containerize various applications following a recent meeting with the application development team. They intend to conduct testing with the following steps:


- Install `docker-ce` and docker compose packages on `App Server 2`.


- Initiate the `docker service`.

## Solution
```bash
# --- Step 2: SSH into App Server 2 (stapp02) ---
ssh steve@stapp02.stratos.xfusioncorp.com
# password: Am3ric@

# --- Step 3: Update packages and install prerequisites ---
sudo yum update -y
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# --- Step 4: Add Docker CE repo ---
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# --- Step 5: Install Docker CE and Docker Compose (plugin) ---
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# --- Step 6: Enable and start docker service ---
sudo systemctl enable docker
sudo systemctl start docker

# --- Step 7: Verify docker installation ---
docker --version
docker compose version   # << use the new plugin
sudo systemctl status docker --no-pager

# --- OPTIONAL: Script version ---
cat << 'EOF' > install_docker.sh
#!/bin/bash
set -e

echo "Updating system..."
yum update -y

echo "Installing prerequisites..."
yum install -y yum-utils device-mapper-persistent-data lvm2

echo "Adding Docker CE repo..."
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "Installing Docker CE and Compose (plugin)..."
yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "Enabling and starting docker service..."
systemctl enable docker
systemctl start docker

echo "Docker setup complete!"
docker --version
docker compose version
EOF

# Run the script
sudo chmod +x install_docker.sh
sudo bash install_docker.sh

## test container
sudo docker run -d -p 8080:80 --name nginx-test nginx
```





