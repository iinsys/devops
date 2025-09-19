Day 46: Deploy an App on Docker Containers

>The secret of success is to do the common things uncommonly well.
>
>– John D. Rockefeller

>To master a new technology, you will have to play with it.
>
>– Jordan Peterson

The Nautilus Application development team recently finished development of one of the apps that they want to deploy on a containerized platform. The Nautilus Application development and DevOps teams met to discuss some of the basic pre-requisites and requirements to complete the deployment. The team wants to test the deployment on one of the app servers before going live and set up a complete containerized stack using a docker compose fie. Below are the details of the task:



On App Server 3 in Stratos Datacenter create a docker compose file `/opt/sysops/docker-compose.yml` (should be named exactly).


The compose should deploy two services (web and DB), and each service should deploy a container as per details below:


`For web service:`


a. Container name must be `php_host`.


b. Use image `php` with any apache tag. Check [here](https://hub.docker.com/_/php?tab=tags/) for more details.


c. Map `php_host` container's port `80` with host port `6100`


d. Map php_host container's `/var/www/html` volume with host volume `/var/www/html`.


For DB service:


a. Container name must be `mysql_host`.


b. Use image mariadb with any tag (preferably latest). Check [here](https://hub.docker.com/_/mariadb?tab=tags/) for more details.


c. Map `mysql_host` container's port `3306` with host port `3306`


d. Map mysql_host container's `/var/lib/mysql` volume with host volume `/var/lib/mysql`.


e. Set `MYSQL_DATABASE=database_host` and use any custom user ( except root ) with some complex password for DB connections.


After running docker-compose up you can access the app with curl command `curl <server-ip or hostname>:6100/`

[For more details check here.](https://hub.docker.com/_/mariadb?tab=description/)


`Note:` Once you click on `FINISH` button, all currently running/stopped containers will be destroyed and stack will be deployed again using your compose file.

## Solution
```bash
# 1. SSH into App Server 2
ssh steve@stapp02.stratos.xfusioncorp.com
# password: Am3ric@

# 2. cd into the directory to create the docker compose file
/opt/sysops/

# 3. Create docker-compose.yml
sudo tee docker-compose.yml > /dev/null <<'EOF'
version: '3.8'

services:
  web:
    container_name: php_host
    image: php:apache
    ports:
      - "6100:80"
    volumes:
      - /var/www/html:/var/www/html

  db:
    container_name: mysql_host
    image: mariadb:latest
    ports:
      - "3306:3306"
    volumes:
      - /var/lib/mysql:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: RootPass123!
      MYSQL_DATABASE: database_host
      MYSQL_USER: appuser
      MYSQL_PASSWORD: Str0ngP@ssw0rd
EOF

# 4. Start the Docker Compose stack
sudo docker-compose -f /opt/security/docker-compose.yml up -d

# 5. Verify containers are running
sudo docker ps

# 6. Test the web app
curl http://localhost:6100/
