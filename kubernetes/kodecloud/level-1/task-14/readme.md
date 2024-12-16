We encountered an issue with our Nginx and PHP-FPM setup on the Kubernetes cluster this morning, which halted its functionality. Investigate and rectify the issue:

The pod name is `nginx-phpfpm` and configmap name is `nginx-config`. Identify and fix the problem.

Once resolved, copy `/home/thor/index.php` file from the jump host to the `nginx-container` within the nginx document root. After this, you should be able to access the `website` using Website button on the top bar.

Note: The `kubectl` utility on `jump_host` is configured to operate with the Kubernetes cluster.

## Solution
```bash
kubectl get pods
kubectl describe pod nginx-phpfpm

## describe config map
kubectl describe configmap nginx-config
##or
kubectl get configmap nginx-config -o yaml

##check logs
kubectl logs nginx-phpfpm -c nginx
kubectl logs nginx-phpfpm -c php-fpm

##use this solutin afte editing the pod nginx-phpfpm make sure all containers have the /var/www/html dir not something else
kubectl replace --force -f /tmp/kubectl-edit-635629484.yaml
kubectl cp index.php nginx-phpfpm:/index.php -c nginx-container
kubectl exec -it nginx-phpfpm -c nginx-container -- /bin/bash
cp index.php /var/www/html
ls -ltr index.php /var/www/html

###Rectify configuration issues
kubectl edit configmap nginx-config
kubectl delete pod nginx-phpfpm


## copy index.php document to root
kubectl exec -it nginx-phpfpm -c nginx -- /bin/sh
ls -ld /usr/share/nginx/html
kubectl cp /home/thor/index.php nginx-phpfpm:/usr/share/nginx/html/index.php -c nginx

##confirm copy
kubectl exec -it nginx-phpfpm -c nginx -- ls /usr/share/nginx/html


### then verify again
kubectl cp /home/thor/index.php nginx-phpfpm:/usr/share/nginx/html/index.php -c nginx-container

kubectl exec -it nginx-phpfpm -c nginx-container -- ls /usr/share/nginx/html


##Verify PHP-FPM Handling in Nginx Configuration
kubectl get configmap nginx-config -o yaml
kubectl delete pod nginx-phpfpm
```