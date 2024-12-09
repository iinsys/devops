```bash
./generate-values.sh

./deploy.sh

echo "sensitive/.env" >> .gitignore

## verify
kubectl get pods
kubectl get svc

## check
kubectl get secrets
kubectl describe secret postgres-secret

kubectl delete secret postgres-secret -n default

kubectl get namespaces


kubectl get secret postgres-secret -n postgres-ns


kubectl get deployments -n postgres-ns
kubectl get svc -n postgres-ns

```

#### Adding pvc to deployment
```bash
kubectl get pvc -n postgres-ns


## check pod to verify volume mount
kubectl describe pod -n postgres-ns
kubectl exec -it <pod-name> -n postgres-ns -- df -h

```