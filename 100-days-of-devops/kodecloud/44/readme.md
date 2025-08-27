Day 44: Write a Docker Compose File

>Picture yourself as an indomitable power filled with positive attitude and faith that you are achieving your goals.
>
>– Napolean Hill

The Nautilus application development team shared static website content that needs to be hosted on the httpd web server using a containerised platform. The team has shared details with the DevOps team, and we need to set up an environment according to those guidelines. Below are the details:



a. On `App Server 1` in Stratos DC create a container named `httpd` using a docker compose file `/opt/docker/docker-compose.yml` (please use the exact name for file).


b. Use `httpd` (preferably latest tag) image for container and make sure container is named as `httpd`; you can use any name for service.


c. Map `80` number port of container with port `8082` of docker host.


d. Map container's `/usr/local/apache2/htdocs` volume with `/opt/itadmin` volume of docker host which is already there. (please do not modify any data within these locations).

## Solution
```bash
# --- Step 2: SSH into App Server 1 ---
ssh tony@stapp01.stratos.xfusioncorp.com
# password: Ir0nM@n

# --- Step 3: Create docker-compose directory ---
sudo mkdir -p /opt/docker
cd /opt/docker

# --- Step 4: Create docker-compose.yml ---
sudo tee /opt/docker/docker-compose.yml > /dev/null <<'EOF'
version: '3'
services:
  webserver:
    image: httpd:latest
    container_name: httpd
    ports:
      - "8082:80"
    volumes:
      - /opt/itadmin:/usr/local/apache2/htdocs
EOF

# --- Step 5: Run docker-compose ---
sudo docker-compose -f /opt/docker/docker-compose.yml up -d

# --- Step 6: Verify container is running ---
sudo docker ps | grep httpd

```






