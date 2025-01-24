One of the Nautilus project developers need access to run docker commands on `App Server 2`. This user is already created on the server. Accomplish this task as per details given below:


User `javed` is not able to run docker commands on `App Server 2` in Stratos DC, make the required changes so that this user can run docker commands without `sudo`.

## Solution
```bash
ssh steve@stapp02.stratos.xfusioncorp.com
#password: Am3ric@

## verify docker installation
docker --version
docker ps

## check docker group
grep docker /etc/group

## if it does not exist then create it
sudo groupadd docker

## add user javed to docker group
sudo usermod -aG docker javed

## reload membership 
su - javed

## or apply new group membership without logging out
newgrp docker

# test docker commands
su - javed
docker ps
## or you can go sudo if you have some complications
```


