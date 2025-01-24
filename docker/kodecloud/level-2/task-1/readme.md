Nautilus project developers are planning to start testing on a new project. As per their meeting with the DevOps team, they want to test containerized environment application features. As per details shared with DevOps team, we need to accomplish the following task:

a. Pull `busybox:musl` image on `App Server 1` in Stratos DC and re-tag (create new tag) this image as `busybox:blog`.

## solution
```bash
## ssh
ssh tony@stapp01.stratos.xfusioncorp.com
## password: Ir0nM@n

## verify docker installation
docker --version
docker ps

## if not installed, install Docker using the commands
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker

## pull busybox:musl image
docker pull busybox:musl

## retag image to busybox:blog
docker tag busybox:musl busybox:blog

## verify images
docker images
```