In response to the latest tool implementation at xFusionCorp Industries, the system admins require the creation of a service user account. Here are the specifics:

Create a user named `kareem` in `App Server 3 `without a home directory.

## Solution
```bash
## using ansible
ansible-playbook -i inventory.ini create_service_user.yml

## Doing it manually
# SSH into App Server 3
ssh banner@172.16.238.12

# Switch to Root User
sudo -i

# Create the User Without a Home Directory
useradd -M kareem

# Verify the User
grep kareem /etc/passwd

##output
kareem:x:1002:1002::/:

## debugging
userdel -r kareem ## delete kareem

## set password for user kareem
sudo passwd kareem

##test
sudo su - kareem
## yous should see
su: warning: cannot change directory to /home/kareem: No such file or directory

pwd

ls -ld /home/kareem


```

**Explanation**
`useradd -M kareem`: Creates a user named `kareem` without a home directory.
`grep kareem /etc/passwd:` Checks if the user has been successfully created and confirms no home directory exists (`:/` as the home directory).
This completes the setup of the kareem service account on `stapp03`.