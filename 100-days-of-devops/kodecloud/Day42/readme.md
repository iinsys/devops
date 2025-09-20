Day 42: Create a Docker Network

>The way to get started is to quit talking and begin doing.
>
>– Walt Disney

The Nautilus DevOps team needs to set up several docker environments for different applications. One of the team members has been assigned a ticket where he has been asked to create some docker networks to be used later. Complete the task based on the following ticket description:


a. Create a docker network named as `beta` on `App Server 2` in Stratos DC.


b. Configure it to use `macvlan` drivers.


c. Set it to use subnet `192.168.30.0/24` and iprange `192.168.30.0/24`.

## Solution
```bash

# --- Step 2: SSH into App Server 2 ---
ssh steve@stapp02.stratos.xfusioncorp.com
# password: Am3ric@

# --- Step 3: Create Docker macvlan network ---
sudo docker network create -d macvlan \
  --subnet=192.168.30.0/24 \
  --ip-range=192.168.30.0/24 \
  beta

# --- Step 4: Verify network creation ---
sudo docker network ls | grep beta
sudo docker network inspect beta


```