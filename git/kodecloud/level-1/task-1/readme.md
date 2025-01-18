The Nautilus development team has provided requirements to the DevOps team for a new application development project, specifically requesting the establishment of a Git repository. Follow the instructions below to create the Git repository on the `Storage server` in the Stratos DC:


1. Utilize `yum` to install the `git` package on the `Storage Server`.

2. Create a bare repository named /opt/media.git (ensure exact name usage)

## Solution
```bash
# Step 1: Connect to the Storage Server
# Log in to the Storage Server (ststor01) using the provided credentials
ssh natasha@172.16.238.15
# Password: Bl@kW

# Step 2: Install Git
# Install the Git package using yum
sudo yum install -y git

# Step 3: Create the Bare Repository
# Navigate to the /opt directory
cd /opt

# Create a bare Git repository named media.git
sudo git init --bare media.git

# Verify the repository creation
ls -ld /opt/media.git
```
