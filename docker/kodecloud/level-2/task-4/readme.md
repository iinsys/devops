One of the Nautilus DevOps team members was working to configure services on a `kkloud` container that is running on `App Server 2` in `Stratos Datacenter`. Due to some personal work he is on PTO for the rest of the week, but we need to finish his pending work ASAP. Please complete the remaining work as per details given below:


- a. Install `apache2` in `kkloud` container using `apt` that is running on `App Server 2` in `Stratos Datacenter`.

- b. Configure Apache to listen on port `6300` instead of default `http` port. Do not bind it to listen on specific IP or hostname only, i.e it should listen on localhost, 127.0.0.1, container ip, etc.

- c. Make sure Apache service is up and running inside the container. Keep the container in running state at the end.

## solution
```bash
# ssh into app server replace with the correct username and ip address
ssh username@app-server-2
## put password

# verify
docker ps


# enter the container
docker exec -it <container_id_or_name> bash


# install apache2
apt update
apt install -y apache2 vim 
apt install -y iproute2

# edit configurations
vi /etc/apache2/ports.conf

# Change the Listen directive: Modify the Listen line to
Listen 6300

# Edit the Apache default virtual host configuration: Open the file /etc/apache2/sites-enabled/000-default.conf
vi /etc/apache2/sites-enabled/000-default.conf

# Update the <VirtualHost> section to:
<VirtualHost *:6300>
    DocumentRoot /var/www/html
</VirtualHost>

# restart apache
service apache2 restart

vi  /etc/apache2/apache2.conf

# add at the bottom or below
ServerName localhost

# restart apache
service apache2 restart
#test the port apache is listening on
ss -tuln | grep 6300

## test
curl http://localhost:6300

#you should see the default nginx page, the ports might change pertask but everything remains the same, port 8085, 8080... and so on
```
