Day 14: Linux Process Troubleshooting

>You can't go back and change the beginning, but you can start where you are and change the ending.
>
>– C.S. Lewis

>Don't give up. Normally it is the last key on the ring which opens the door.
>
>– Paulo Coelho

The production support team of xFusionCorp Industries has deployed some of the latest monitoring tools to keep an eye on every service, application, etc. running on the systems. One of the monitoring systems reported about Apache service unavailability on one of the app servers in Stratos DC.

Identify the faulty app host and fix the issue. Make sure `Apache service` is up and running on all app hosts. They might not hosted any code yet on these servers so you need not to worry about if Apache isn't serving any pages or not, just make sure service is up and running. Also, make sure Apache is running on port `6200` on all app servers.

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# 0. SSH into each app server (replace with your actual private key path if needed)
ssh tony@stapp01
ssh steve@stapp02
ssh banner@stapp03

# 1. Become root
sudo -i

# 2. Install Apache (httpd)
yum install -y httpd

# 3. Change Apache default port from 80 to 6200
sed -i 's/^Listen .*/Listen 6200/' /etc/httpd/conf/httpd.conf

# 4. (Optional) Confirm port is set correctly
grep "^Listen" /etc/httpd/conf/httpd.conf

# 5. Allow port 6200 via firewalld
firewall-cmd --permanent --add-port=6200/tcp
firewall-cmd --reload

# 6. Start and enable Apache service
systemctl daemon-reexec
systemctl start httpd
systemctl enable httpd

# 7. Debugging: Check which process is using port 6200
lsof -i :6200

# 8. Confirm Apache is listening on port 6200
ss -tuln | grep 6200

# 9. Check Apache status for any errors
systemctl status httpd
```