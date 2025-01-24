One of the DevOps team member was trying to install a WordPress website on a LAMP stack which is essentially deployed on Kubernetes cluster. It was working well and we could see the installation page a few hours ago. However something is messed up with the stack now due to a website went down. Please look into the issue and fix it:


FYI, deployment name is `lamp-wp` and its using a service named `lamp-service`. The Apache is using http default port and nodeport is `30008`. From the application logs it has been identified that application is facing some issues while connecting to the database in addition to other issues. Additionally, there are some environment variables associated with the pods like `MYSQL_ROOT_PASSWORD, MYSQL_DATABASE,  MYSQL_USER, MYSQL_PASSWORD, MYSQL_HOST`.

Also do not try to delete/modify any other existing components like deployment name, service name, types, labels etc.


`Note`: The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
k get deploy

k describe deploy lamp-wp

k get svc

k edit svc lamp-service

# check the service to see if the port is actually 30008 and also the port external and internal should be 80

k get svc

k get cm

k describe cm php-config

k get deploy

k get pods

k describe pod lamp-wp-56c7c454fc-rkz8b 

k exec -it lamp-wp-56c7c454fc-rkz8b -c httpd-php-container -- sh

ls 
cd /app
ls
cat index.php
exit
vi index.php

 kubectl create configmap --help

kubectl create configmap index --from-file=index.php

k get cm

k describe cm index

k edit deployments.apps lamp-wp

## you should add this to that sectiion of the file as we have in the deployment.txt file

- mountPath: /app/index.php

k get pods

k describe pods <pod name>

and you should check to see this 
/app/index.php from index (rw,path="index.php")

kubectl exec -it lamp-wp-5cdd848bfb-s47cn -c httpd-php-container -- sh