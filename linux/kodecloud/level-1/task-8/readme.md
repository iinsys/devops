Within the Stratos DC, the Nautilus storage server hosts a directory named `/data`, serving as a repository for various developers non-confidential data. Developer kirsty has requested a copy of their data stored in `/data/kirsty`. The System Admin team has provided the following steps to fulfill this request:

- a. Create a compressed archive named kirsty.tar.gz of the `/data/kirsty` directory.

- b. Transfer the archive to the /home directory on the Storage Server.

### Solution
```bash
##Connect to the Jump Server
   ssh thor@<Jump_Server_IP> 

# Replace <Jump_Server_IP> with the IP address of the Jump Server (dynamic in this case).

# Username: thor
# Password: mjolnir123

## ssh into the storage server
ssh natasha@172.16.238.15

## Create a compressed archive
cd /data
tar -czvf kirsty.tar.gz kirsty

## Move the archive to the /home directory
mv kirsty.tar.gz /home

## verify
ls /home/kirsty.tar.gz 

# Optionally, verify the contents of the archive:
tar -tzvf /home/kirsty.tar.gz
```
