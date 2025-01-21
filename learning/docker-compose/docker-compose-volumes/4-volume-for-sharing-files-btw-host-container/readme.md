###  Volume for Sharing Files Between Host and Container
Use volumes to share files between your local machine and a container.

Scenario**
You want a web server to serve content from your local machine.

**How It Works**
Mount the html folder in your project directory to /usr/share/nginx/html inside the container.
Place an index.html file in the html directory, and it will be served by Nginx.