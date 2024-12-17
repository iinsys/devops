An issue has arisen with a static website running in a container named nautilus on App Server 1. To resolve the issue, investigate the following details:

1. Check if the container's volume /usr/local/apache2/htdocs is correctly mapped with the host's volume /var/www/html.

2. Verify that the website is accessible on host port 8080 on App Server 1. Confirm that the command curl http://localhost:8080/ works on App Server 1.

## Solution
```bash
## ssh into app server 1
ssh tony@stapp01.stratos.xfusioncorp.com
Password: Ir0nM@n

### docker ps 
docker ps -a

## verify volume mapping 
docker inspect nautilus | grep -i "source\|destination"

## it should be something like this:
#Ensure that:
#The host path /var/www/html is correctly mapped to the container path /usr/local/apache2/htdocs

## test website locally
curl http://localhost:8080/
## you should see some error message

## troubleshooting
# Verify port binding
docker inspect nautilus | grep -i "8080"

## restart the container
docker stop nautilus
docker rm nautilus
docker run -d --name nautilus -p 8080:80 -v /var/www/html:/usr/local/apache2/htdocs httpd

## check logs
docker logs nautilus

## exit
exit
```