Day 10: Automate Website Backup with Bash Script

>The most important thing to do in solving a problem is to begin.
>
>– Frank Tyger

Create a bash script `/scripts/ecommerce_backup.sh` that:

a.) Creates a zip archive `xfusioncorp_ecommerce.zip` of `/var/www/html/ecommerce`

b.) Saves the archive under `/backup/` on App Server 2 (temporary location)

c.) Copies the archive to the Backup Server (stbkp01) in `/backup/`

d.) Ensures password-less `scp` via SSH key authentication

## Infrastructure Details

| Server | Hostname | User | Password | Purpose |
|--------|----------|------|----------|---------|
| stapp02 | stapp02.stratos.xfusioncorp.com | steve | Am3ric@ | App Server 2 |
| stbkp01 | stbkp01.stratos.xfusioncorp.com | clint | H@wk3y3 | Backup Server |

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# 1. Switch to App Server 2
ssh steve@stapp02

# 2. Create the required directories if they don't exist
sudo mkdir -p /scripts
sudo mkdir -p /backup

# 3. Create the backup script
sudo tee /scripts/ecommerce_backup.sh > /dev/null << 'EOF'
#!/bin/bash

# Create zip archive of the ecommerce directory
zip -r /backup/xfusioncorp_ecommerce.zip /var/www/html/ecommerce > /dev/null

# Copy to backup server using SSH
scp /backup/xfusioncorp_ecommerce.zip clint@stbkp01:/backup/
EOF

# 4. Make the script executable
sudo chmod +x /scripts/ecommerce_backup.sh

# 5. Setup SSH key-based authentication from stapp02 to stbkp01
# On stapp02 as user steve:
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""  # If not already generated
ssh-copy-id clint@stbkp01                        # Enter password H@wk3y3 when prompted

# 6. Test the script
/scripts/ecommerce_backup.sh
```

## Expected Output
Archive file created: `/backup/xfusioncorp_ecommerce.zip`
Archive transferred to `stbkp01:/backup/`

## Verification on Backup Server
```bash
ssh clint@stbkp01
ls -l /backup/
# -rw-r--r-- 1 clint clint 623 Jul 15  xfusioncorp_ecommerce.zip
```