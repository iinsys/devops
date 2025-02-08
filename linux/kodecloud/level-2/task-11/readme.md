We have some users on all app servers in `Stratos Datacenter`. Some of them have been assigned some new roles and responsibilities, therefore their users need to be upgraded with sudo access so that they can perform admin level tasks.

a. Provide sudo access to user `kareem` on all app servers.

b. Make sure you have set up password-less sudo for the user.

## Solution
```bash
## ssh into each of the servers(stratos datacenter)
ssh tony@stapp01.stratos.xfusioncorp.com
ssh steve@stapp02.stratos.xfusioncorp.com
ssh banner@stapp03.stratos.xfusioncorp.com

## on each server do this 
#  Add User kareem (If Not Exists)
sudo useradd -m -s /bin/bash kareem

## optional(set password for kareem)
sudo passwd kareem

# Add kareem to the sudoers File, To grant password-less sudo access, edit the sudoers file:
echo 'kareem ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/kareem

# verify sudoers file
sudo visudo -c


#Verify sudo Access
su - kareem
sudo whoami

# it should return
root


# using bash script
sudo apt install sshpass  # Ubuntu/Debian
sudo yum install sshpass  # RHEL/CentOS


chmod +x grant_sudo.sh


./grant_sudo.sh

```
Repeat for All App Servers
Run the above steps on stapp01, stapp02, and stapp03.