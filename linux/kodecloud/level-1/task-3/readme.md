To accommodate the backup agent tool's specifications, the system admin team at xFusionCorp Industries requires the creation of a user with a non-interactive shell. Here's your task:

Create a user named james with a non-interactive shell on App Server 1.

### Solution
```bash
## using ansibible
ansible-playbook -i inventory.ini create_user.yaml

## Doing manually 
# SSH into the App Server
ssh tony@172.16.238.10

# Switch to Root
sudo -i

# Create the User with a Non-Interactive Shell
useradd -s /sbin/nologin james

# Verify the User
cat /etc/passwd | grep james

## output
james:x:1002:1002::/home/james:/sbin/nologin

```