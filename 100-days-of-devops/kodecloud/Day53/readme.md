Day 53: Resolve VolumeMounts Issue in Kubernetes

>Always bear in mind that your own resolution to success is more important than any other one thing.
>
>– Abraham Lincoln


>Do the best you can. No one can do more than that.
>
>– John Wooden

We encountered an issue with our Nginx and PHP-FPM setup on the Kubernetes cluster this morning, which halted its functionality. Investigate and rectify the issue:



The pod name is `nginx-phpfpm` and configmap name is `nginx-config`. Identify and fix the problem.


Once resolved, copy `/home/thor/index.php` file from the jump host to the `nginx-container` within the nginx document root. After this, you should be able to access the website using Website button on the top bar.


`Note`: The `kubectl` utility on `jump_host` is configured to operate with the Kubernetes cluster.

## Solution
```bash
# 1. Check the pod and configmap
kubectl get pods -o wide
kubectl get configmap nginx-config -o yaml

# 2. Fix SCRIPT_FILENAME in the ConfigMap to match nginx root
kubectl get configmap nginx-config -o yaml \
| sed 's#fastcgi_param SCRIPT_FILENAME .*#fastcgi_param SCRIPT_FILENAME /var/www/html$fastcgi_script_name;#' \
| kubectl apply -f -

# 3. Reload nginx to apply the new config
kubectl exec nginx-phpfpm -c nginx-container -- nginx -s reload || \
kubectl exec nginx-phpfpm -c nginx-container -- sh -lc 'kill -HUP 1'

# 4. Copy index.php from jump host to nginx-container
kubectl cp /home/thor/index.php nginx-phpfpm:/var/www/html/index.php -c nginx-container

# 5. Verify index.php exists in nginx-container
kubectl exec -it nginx-phpfpm -c nginx-container -- ls -l /var/www/html/

# 6. Test the web app from within nginx-container
kubectl exec -it nginx-phpfpm -c nginx-container -- curl http://localhost:8099/

# After this, the Website button should display the PHP page correctly

```