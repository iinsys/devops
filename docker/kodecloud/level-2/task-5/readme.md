As per recent requirements shared by the Nautilus application development team, they need custom images created for one of their projects. Several of the initial testing requirements are already been shared with DevOps team. Therefore, create a docker file `/opt/docker/Dockerfile` (please keep `D` capital of Dockerfile) on `App server 2` in `Stratos DC` and configure to build an image with the following requirements:

- a. Use `ubuntu` as the base image.

- b. Install `apache2` and configure it to work on `8089` port. (do not update any other Apache configuration settings like document root etc).

## Solution
```bash
ssh steve@stapp02.stratos.xfusioncorp.com
##password:Am3ric@

# make directory
sudo mkdir -p /opt/docker

#create docker file and contents
sudo vi /opt/docker/Dockerfile

cd /opt/docker

## build image
sudo docker build -t custom-apache-image .

## run
sudo docker run -d --name apache-container -p 8089:8089 custom-apache-image

# test
curl http://localhost:8089

