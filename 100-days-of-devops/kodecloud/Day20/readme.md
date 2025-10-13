Day 20: Configure Nginx + PHP-FPM Using Unix Sock

>All you need is the plan, the road map, and the courage to press on to your destination.
>
>– Earl Nightingale

The Nautilus application development team is planning to launch a new `PHP-based` application, which they want to deploy on Nautilus infra in Stratos DC. The development team had a meeting with the production support team and they have shared some requirements regarding the infrastructure. Below are the requirements they shared:


a. Install nginx on app server 2 , configure it to use port `8093` and its document root should be `/var/www/html`.


b. Install php-fpm version 8.1 on app server 2, it must use the unix socket `/var/run/php-fpm/default`.sock (create the parent directories if don't exist).


c. Configure `php-fpm` and `nginx` to work together.


d. Once configured correctly, you can test the website using `curl http://stapp02:8093/index.php` command from jump host.


## Soluton 
```bash
## Step 2: SSH into App Server 2
ssh steve@stapp02.stratos.xfusioncorp.com
# password: Am3ric@

## Step 3: Install nginx
sudo yum install epel-release -y
sudo yum install nginx -y

## Step 4: Install PHP 8.1 and php-fpm
sudo yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum install -y yum-utils
sudo yum-config-manager --enable remi-php81
sudo yum install -y php php-cli php-common php-fpm

## Step 5: Configure php-fpm to use /var/run/php-fpm/default.sock
sudo mkdir -p /var/run/php-fpm
sudo sed -i 's|^listen = .*|listen = /var/run/php-fpm/default.sock|' /etc/php-fpm.d/www.conf
sudo sed -i 's|^;listen.owner = nobody|listen.owner = nginx|' /etc/php-fpm.d/www.conf
sudo sed -i 's|^;listen.group = nobody|listen.group = nginx|' /etc/php-fpm.d/www.conf
sudo sed -i 's|^;listen.mode = 0660|listen.mode = 0660|' /etc/php-fpm.d/www.conf
sudo sed -i 's|^user = apache|user = nginx|' /etc/php-fpm.d/www.conf
sudo sed -i 's|^group = apache|group = nginx|' /etc/php-fpm.d/www.conf

## Step 6: Configure nginx to listen on port 8093 and work with php-fpm
sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak

sudo sed -i '/http {/a\
server {\
    listen 8093;\
    server_name _;\
    root /var/www/html;\
    index index.php index.html index.htm;\
    location / {\
        try_files $uri $uri/ =404;\
    }\
    location ~ \\.php$ {\
        include fastcgi_params;\
        fastcgi_pass unix:/var/run/php-fpm/default.sock;\
        fastcgi_index index.php;\
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;\
    }\
}' /etc/nginx/nginx.conf

## Step 7: Create test PHP file
sudo mkdir -p /var/www/html
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/index.php

## Step 8: Start and enable services
sudo systemctl enable nginx
sudo systemctl enable php-fpm
sudo systemctl restart php-fpm
sudo systemctl restart nginx

## Step 9: Open firewall port 8093
sudo firewall-cmd --permanent --add-port=8093/tcp
sudo firewall-cmd --reload

## Step 10: Verify website locally and remotely
# From App Server 2:
curl http://localhost:8093/index.php

# From Jump Host:
curl http://stapp02:8093/index.php

#  You should see the PHP info page displayed confirming the setup works.
```
