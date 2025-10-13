Day 19: Install and Configure Web Application

>You can’t go back and change the beginning, but you can start where you are and change the ending.
>
>– C.S. Lewis

>Be not in despair, the way is very difficult, like walking on the edge of a razor; yet despair not, arise, awake, and find the ideal, the goal.
>
>– Swami Vivekananda

>For success attitude is equally important as ability.
>
>– Harry F.Bank

xFusionCorp Industries is planning to host two static websites on their infra in Stratos Datacenter. The development of these websites is still in-progress, but we want to get the servers ready. Please perform the following steps to accomplish the task:



a. Install httpd package and dependencies on app server 3.


b. Apache should serve on port `6400`.


c. There are two website's backups /home/thor/news and /home/thor/demo on jump_host. Set them up on Apache in a way that news should work on the link http://localhost:6400/news/ and demo should work on link http://localhost:6400/demo/ on the mentioned app server.


d. Once configured you should be able to access the website using curl command on the respective app server, i.e `curl http://localhost:6400/news/` and `curl http://localhost:6400/demo/`

## Solution 
```bash
## Step 2: Copy website backups to App Server 3
scp -r /home/thor/news banner@stapp03.stratos.xfusioncorp.com:/tmp/
scp -r /home/thor/demo banner@stapp03.stratos.xfusioncorp.com:/tmp/
# password: BigGr33n

## Step 3: SSH into App Server 3
ssh banner@stapp03.stratos.xfusioncorp.com
# password: BigGr33n

## Step 4: Install Apache (httpd)
sudo yum install httpd -y

## Step 5: Configure Apache to listen on port 6400
sudo vi /etc/httpd/conf/httpd.conf
# Find "Listen 80" and change it to:
Listen 6400

## Step 6: Move static site files into Apache web root
sudo mv /tmp/news /var/www/html/
sudo mv /tmp/demo /var/www/html/

# Final directory structure:
# /var/www/html/index.html
# /var/www/html/news/*
# /var/www/html/demo/*

## Step 7: Create Apache site configuration
sudo vi /etc/httpd/conf.d/sites.conf

# Add the following configuration:
<VirtualHost *:6400>
    DocumentRoot /var/www/html

    Alias /news /var/www/html/news
    <Directory /var/www/html/news>
        Require all granted
    </Directory>

    Alias /demo /var/www/html/demo
    <Directory /var/www/html/demo>
        Require all granted
    </Directory>
</VirtualHost>

## Step 8: Restart Apache service
sudo systemctl restart httpd
sudo systemctl enable httpd

## Step 9: Verify websites are accessible
curl http://localhost:6400/news/
curl http://localhost:6400/demo/

#  Both should display the HTML content of the respective static sites.

```
