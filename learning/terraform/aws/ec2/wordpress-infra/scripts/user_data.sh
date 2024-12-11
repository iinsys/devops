#!/bin/bash
sudo yum update -y
sudo yum install -y httpd mariadb-server
sudo systemctl start httpd
sudo systemctl enable httpd

# Download and configure WordPress
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
sudo cp -r wordpress/* /var/www/html/
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

# Enable PHP and restart the web server
sudo amazon-linux-extras enable php7.4
sudo yum install -y php php-mysqlnd
sudo systemctl restart httpd
