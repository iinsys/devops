Day 15: Setup SSL for Nginx

>The only thing standing between you and outrageous success is continuous progress.
>
>– Dan Waldschmidt

The system admins team of xFusionCorp Industries needs to deploy a new application on `App Server 2` in Stratos Datacenter. They have some pre-requites to get ready that server for application deployment. Prepare the server as per requirements shared below:



1. Install and configure nginx on App Server 2.


2. On App Server 2 there is a self signed SSL certificate and key present at location  `/tmp/nautilus.crt` and `/tmp/nautilus.key`. Move them to some appropriate location and deploy the same in Nginx.


3. Create an `index.html` file with content` Welcome! under Nginx document root`.


4. For final testing try to access the App Server 2 link (either hostname or IP) from jump host using curl command. For example `curl -Ik https://<app-server-ip>/`.

## Solution
```bash
# SSH from jump host
ssh steve@stapp02
# Password: Am3ric@

# Install nginx
sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Move SSL files
sudo mkdir -p /etc/nginx/ssl
sudo mv /tmp/nautilus.crt /etc/nginx/ssl/
sudo mv /tmp/nautilus.key /etc/nginx/ssl/

# Configure nginx SSL
cat <<EOF | sudo tee /etc/nginx/conf.d/ssl.conf
server {
    listen 443 ssl;
    server_name stapp02.stratos.xfusioncorp.com;

    ssl_certificate /etc/nginx/ssl/nautilus.crt;
    ssl_certificate_key /etc/nginx/ssl/nautilus.key;

    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# Create index.html
echo "Welcome!" | sudo tee /usr/share/nginx/html/index.html

# Test and reload nginx
sudo nginx -t && sudo systemctl reload nginx

# From jump host: test with curl
curl -Ik https://stapp02.stratos.xfusioncorp.com/

```




