## Easy Install With Docker
You can test ManageIQ running in a Docker container using the images that the ManageIQ project makes available on the Docker Hub. This is a great option if you have a Linux PC (but it works everywhere Docker is available).

If you are on Linux, make sure the Docker service is running:
```bash
sudo systemctl status docker
```
**Step 1: Download and deploy the appliance**
Pull the ManageIQ docker image:
```bash
docker pull manageiq/manageiq:quinteros-2.2
```
**Step 2: Run the container**
```bash
 docker run -d -p 8443:443 manageiq/manageiq:quinteros-2.2

## Access application here 
https://localhost:8443
default password: smartvm
username: admin
```
ManageIQ is now up and running.

Next step is to perform some basic configuration.