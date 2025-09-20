Day 16: Install and Configure Nginx as an LBR


>Sometimes things aren’t clear right away. That’s where you need to be patient and persevere and see where things lead.
>
>– Mary Pierce

Day by day traffic is increasing on one of the websites managed by the Nautilus production support team. Therefore, the team has observed a degradation in website performance. Following discussions about this issue, the team has decided to deploy this application on a high availability stack i.e on Nautilus infra in Stratos DC. They started the migration last month and it is almost done, as only the LBR server configuration is pending. Configure LBR server as per the information given below:



a. Install `nginx` on `LBR (load balancer)` server.


b. Configure load-balancing with the an http context making use of all App Servers. Ensure that you update only the main Nginx configuration file located at `/etc/nginx/nginx.conf`.


c. Make sure you do not update the apache port that is already defined in the apache configuration on all app servers, also make sure apache service is up and running on all app servers.

## Solution
```bash
# ================================
# Day 16 - Configure Nginx LBR
# ================================

# 1. SSH into the Load Balancer server (stlb01)
ssh loki@stlb01.stratos.xfusioncorp.com
# password: Mischi3f

# 2. Install nginx (if not already installed)
sudo yum install -y nginx

# 3. Enable and start nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# 4. Edit the main nginx config file
sudo vi /etc/nginx/nginx.conf

# Replace its content with the following:

##########################################
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 4096;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    #  Define backend app servers (Apache runs on port 6000)
    upstream backend {
        server 172.16.238.10:6000;
        server 172.16.238.11:6000;
        server 172.16.238.12:6000;
    }

    #  Load balancer server block
    server {
        listen       80;
        listen       [::]:80;
        server_name  _;

        location / {
            proxy_pass http://backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
            root /usr/share/nginx/html;
        }
    }
}
##########################################

# 5. Test nginx configuration
sudo nginx -t

# 6. Reload nginx
sudo systemctl reload nginx

# 7. Debug: Verify each Apache backend is running on port 6000
ssh tony@stapp01.stratos.xfusioncorp.com -t "sudo ss -tulnp | grep 6000"
ssh steve@stapp02.stratos.xfusioncorp.com -t "sudo ss -tulnp | grep 6000"
ssh banner@stapp03.stratos.xfusioncorp.com -t "sudo ss -tulnp | grep 6000"

# 8. Test from Load Balancer
curl -I http://172.16.238.14/

# 9. Test from Jump Host (final check)
ssh thor@jump_host.stratos.xfusioncorp.com
# password: mjolnir123
curl -I http://172.16.238.14/

# You should see: HTTP/1.1 200 OK
# ================================


```