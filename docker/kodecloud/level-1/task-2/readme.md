The Nautilus DevOps team is conducting application deployment tests on selected application servers. They require a nginx container deployment on Application Server 1. Complete the task with the following instructions:

1. On Application Server 1 create a container named nginx_1 using the nginx image with the alpine tag. Ensure container is in a running state.

## Solution
Always make use of the documentation [Kodecloud documentation](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus#infrastructure-details)

```bash
##ssh into server 1
ssh tony@172.16.238.10
<put password>

## Verification of docker installation
docker --version
systemctl status docker

##pull nginx image
docker pull nginx:alpine

##Run container 
docker run -d --name nginx_1 nginx:alpine

## see containers running 
docker ps
## debugging
docker logs nginx_1

```