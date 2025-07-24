>The most important thing to do in solving a problem is to begin.
>
>– Frank Tyger

# Day 10 – DevOps Daily Task
- ---------------------------------------
- 🎯 Task: Automate Website Backup with Bash Script
- 🗓️ Date: Day 8
- 📍 Location: App Server 2 (stapp02.stratos.xfusioncorp.com)
- 👤 User: steve
- 🔐 Password: Am3ric@

### 📝 Task Objective:
- Create a bash script `/scripts/ecommerce_backup.sh` that:
- a. Creates a zip archive `xfusioncorp_ecommerce.zip` of `/var/www/html/ecommerce`
- b. Saves the archive under `/backup/` on App Server 2 (temporary location)
- c. Copies the archive to the Backup Server (stbkp01) in `/backup/`
- d. Ensures password-less `scp` via SSH key authentication

```bash
# 📌 Backup Server Details:
# Hostname: stbkp01.stratos.xfusioncorp.com
# IP: 172.16.238.16
# User: clint
# Password: H@wk3y3

# ✅ Steps Performed:

# 1️⃣ Switch to App Server 2
ssh steve@stapp02

# 2️⃣ Create the required directories if they don’t exist
sudo mkdir -p /scripts
sudo mkdir -p /backup

# 3️⃣ Create the backup script
sudo tee /scripts/ecommerce_backup.sh > /dev/null << 'EOF'
#!/bin/bash

# Create zip archive of the ecommerce directory
zip -r /backup/xfusioncorp_ecommerce.zip /var/www/html/ecommerce > /dev/null

# Copy to backup server using SSH
scp /backup/xfusioncorp_ecommerce.zip clint@stbkp01:/backup/
EOF

# 4️⃣ Make the script executable
sudo chmod +x /scripts/ecommerce_backup.sh

# 5️⃣ Setup SSH key-based authentication from stapp02 to stbkp01
# On stapp02 as user steve:
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""  # If not already generated
ssh-copy-id clint@stbkp01                        # Enter password H@wk3y3 when prompted

# 6️⃣ Test the script
/scripts/ecommerce_backup.sh

# ✅ Expected Output
# Archive file created:
#   /backup/xfusioncorp_ecommerce.zip
# Archive transferred to stbkp01:/backup/

# Example Output from Running the Script:
# [steve@stapp02 ~]$ /scripts/ecommerce_backup.sh
#   adding: var/www/html/ecommerce/ (stored 0%)
#   adding: var/www/html/ecommerce/.gitkeep (stored 0%)
#   adding: var/www/html/ecommerce/index.html (stored 0%)
# xfusioncorp_ecommerce.zip                 100%  623     1.2MB/s   00:00    

# ✅ Verification on Backup Server (stbkp01):
# ssh clint@stbkp01
# ls -l /backup/
# -rw-r--r-- 1 clint clint 623 Jul 15  xfusioncorp_ecommerce.zip

# 🏁 Task Completed Successfully
```