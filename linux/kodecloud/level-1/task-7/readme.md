## Task: Secure Root SSH Access
Following security audits, the `xFusionCorp Industries` security team has rolled out new protocols, including the restriction of direct root SSH login.

Your task is to disable direct SSH root login on all app servers within the `Stratos Datacenter`.

## Solution
1. **SSH into Each App Server**
From the Jump Server, SSH into each app server (`stapp01, stapp02, stapp03`) using the respective credentials:
```bash
ssh tony@172.16.238.10   # stapp01
ssh steve@172.16.238.11  # stapp02
ssh banner@172.16.238.12 # stapp03
```

2. **Edit the SSH Configuration File**
Once logged in, edit the `/etc/ssh/sshd_config` file on the server to disable root login:
```bash
sudo vi /etc/ssh/sshd_config
```
Locate the line that says:
```bash
PermitRootLogin yes
```
Change it to
```bash
PermitRootLogin no
```
If the line is commented out, uncomment it by removing the `#`.

4. **Restart the SSH Service**
After saving the changes, restart the SSH service to apply the configuration:
```bash
sudo systemctl restart sshd
```
5. **Verify the Configuration**
Attempt to log in as root via SSH to confirm the restriction:
```bash
ssh root@<server-ip>
```
It should deny the login attempt.

6. **Repeat for All App Servers**
Perform the same steps for s`tapp02` and `stapp03`.

**Notes**
For Other Servers
The task specifies `"app servers"` (stapp01, stapp02, stapp03), so you don't need to configure the other servers unless explicitly required.

**Backup SSH Configuration**
Before editing, consider creating a backup of the SSH configuration file:
```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
```
Revert Changes if Necessary
If something goes wrong, you can restore the original configuration:
```bash
sudo mv /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
sudo systemctl restart sshd
```

#### Using ansible
```bash
## install ansible
sudo yum update -y
sudo yum install ansible -y
ansible --version

## using ssh key to authenticate
ssh-keygen -t rsa -b 2048

ssh-copy-id -i ~/.ssh/id_rsa.pub tony@172.16.238.10
ssh-copy-id -i ~/.ssh/id_rsa.pub steve@172.16.238.11
ssh-copy-id -i ~/.ssh/id_rsa.pub banner@172.16.238.12


ansible-playbook -i inventory.ini disable_root_login.yml
## check
ssh root@172.16.238.10
```
