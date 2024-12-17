The Nautilus DevOps team possesses confidential data on App Server 1 in the Stratos Datacenter. A container named ubuntu_latest is running on the same server.

Copy an encrypted file /tmp/nautilus.txt.gpg from the docker host to the ubuntu_latest container located at /usr/src/. Ensure the file is not modified during this operation.

## Solution
```bash
## ssh into app server 1
ssh tony@stapp01.stratos.xfusioncorp.com
Password: Ir0nM@n

### check the containers running
docker ps -a

## copy file to directory
docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/usr/src/

## Verify the file in the container
docker exec -it ubuntu_latest /bin/bash
ls -l /usr/src/
exit

```