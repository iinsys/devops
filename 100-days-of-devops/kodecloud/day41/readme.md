Day 41: Write a Docker File

>IT'S THE will, NOT THE skill..
>
>– Jim Bunney

As per recent requirements shared by the Nautilus application development team, they need custom images created for one of their projects. Several of the initial testing requirements are already been shared with DevOps team. Therefore, create a docker file `/opt/docker/Dockerfile` (please keep D capital of Dockerfile) on `App server 1` in Stratos DC and configure to build an image with the following requirements:



a. Use `ubuntu:24.04` as the base image.


b. Install `apache2` and configure it to work on `3000` port. (do not update any other Apache configuration settings like document root etc).

## Solution
```bash
# --- Step 2: SSH into App Server 1 ---
ssh tony@stapp01.stratos.xfusioncorp.com
# password: Ir0nM@n

# --- Step 3: Create docker build directory ---
sudo mkdir -p /opt/docker
cd /opt/docker

# --- Step 4: Create Dockerfile ---
sudo tee /opt/docker/Dockerfile > /dev/null <<'EOF'
FROM ubuntu:24.04

# Install Apache
RUN apt-get update && apt-get install -y apache2 && apt-get clean

# Change Apache listen port from 80 to 3000
RUN sed -i 's/80/3000/g' /etc/apache2/ports.conf \
    && sed -i 's/:80/:3000/g' /etc/apache2/sites-available/000-default.conf

# Expose port 3000
EXPOSE 3000

# Start Apache in foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EOF

# --- Step 5: Build custom image ---
sudo docker build -t custom-apache:3000 /opt/docker

# --- Step 6: Run container from new image (test) ---
sudo docker run -d --name apache_test -p 3000:3000 custom-apache:3000

# --- Step 7: Verify Apache is running inside container ---
sudo docker ps | grep apache_test
curl http://localhost:3000

```