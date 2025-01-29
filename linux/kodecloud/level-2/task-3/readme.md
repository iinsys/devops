The Nautilus team doesn't want its data to be accessed by any of the other `groups/teams` due to security reasons and want their data to be strictly accessed by the devops group of the team.

Setup a collaborative directory `/devops/data` on `app server 2 `in `Stratos Datacenter`.

The directory should be group owned by the group `devops` and the group should own the files inside the directory. The directory should be `read/write/execute` to the user and group owners, and `others` should not have any access.

## Solution
```bash
ssh steve@172.16.238.11
# password:Am3ric@

# Create the devops Group: Check if the devops group exists:
getent group devops
# if it does not exist then create it
sudo groupadd devops

# Create the Directory /devops/data
sudo mkdir -p /devops/data

# Set the Group Ownership to devops
sudo chown :devops /devops/data

# Set the Correct Permissions
# Give read, write, and execute permissions to the group and owner, and restrict access for others:
sudo chmod 770 /devops/data

# 7 → Full (rwx) access for owner.
# 7 → Full (rwx) access for group.
# 0 → No access for others.

# Enable Group Sticky Bit
# This ensures that any new files created inside /devops/data inherit the devops group ownership
sudo chmod g+s /devops/data

#  Add Users to the devops Group
# If there are specific users who need access, add them:
sudo usermod -aG devops steve  # Add steve to devops group

# Verify user membership:
groups steve

# Verification
# Check the directory ownership:
ls -ld /devops/data

# Expected output:
drwxrws--- 2 root devops 4096 Jul 10 12:34 /devops/data

# d → Directory
# rwxrws--- → Owner and group have full access, others have none.
# devops → Group ownership.

# Test by creating a file inside /devops/data:
sudo -u steve touch /devops/data/testfile
ls -l /devops/data

# Expected output:
-rw-rw---- 1 steve devops 0 Jul 10 12:35 testfile
```

**Automating with Ansible**
Create a playbook (`setup_devops_dir.yml`) to automate this setup:
```bash
ansible-playbook -i inventory.ini setup_devops_dir.yml --ask-become-pass
