The `Nautilus` production support team and security team had a meeting last month in which they decided to use local yum repositories for maintaing packages needed for their servers. For now they have decided to configure a local yum repo on `Nautilus Backup Server`. This is one of the pending items from last month, so please configure a local yum repository on Nautilus Backup Server as per details given below.

a. We have some packages already present at location `/packages/downloaded_rpms/` on `Nautilus Backup Server`.

b. Create a yum repo named `local_yum` and make sure to set `Repository ID` to `local_yum`. Configure it to use package's location `/packages/downloaded_rpms/`.

c. Install package `samba` from this newly created repo.

## Solution
```bash
##login to backup server
ssh clint@172.16.238.16
#password:H@wk3y3

## Create YUM Repository File: Create a new YUM repository configuration file:
sudo vi /etc/yum.repos.d/local_yum.repo

## add the following content
[local_yum]
name=Local YUM Repository
baseurl=file:///packages/downloaded_rpms/
enabled=1
gpgcheck=0

# Clean YUM Cache and Verify Repository, Run the following commands to clean and list the repository:
sudo yum clean all
sudo yum repolist

# You should see local_yum in the list.

# Install Samba from Local Repository, Now, install samba using the newly created repo:
sudo yum install samba -y --disablerepo="*" --enablerepo="local_yum"

#This ensures that samba is installed only from local_yum.

# Verify Samba Installation
rpm -q samba

## debug
##  Restart YUM Service
sudo yum makecache
