#### Commands to use example-1
```bash
kubectl apply -f envvar1.yml
kubectl exec -it example-1 printenv | egrep "^PORT|SERVICE_NAME"
kubectl delete pod example-1 
```
#### Commands to use example-2
```bash
kubectl apply -f envvar2.yml 
kubectl logs -f example-2
```
#### Commands to use example-3
```bash
touch app.properties
kubectl create configmap app-properties --from-env-file=app.properties
kubectl apply -f envvar3.yml
kubectl logs -f example-3

```

#### Commands to use example-4
```bash
echo -n 'put password here' | base64
## mysql root password yaml file is used for example-4
kubectl apply -f mysql_root_password.yml
kubctl get secrets
kubectl get pod example-4 --watch
kubectl logs -f example-4 
```

