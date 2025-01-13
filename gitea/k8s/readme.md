```bash

## create secrets
kubectl create secret generic gitea-db-secret \
  --from-literal=MYSQL_ROOT_PASSWORD=rootpassword \
  --from-literal=MYSQL_PASSWORD=yourpassword \
  --from-literal=MYSQL_USER=gitea \
  --from-literal=MYSQL_DATABASE=gitea

### apply files
kubectl apply -f gitea-db-deployment.yaml
kubectl apply -f gitea-deployment.yaml
kubectl apply -f gitea-pvc.yaml
kubectl apply -f gitea-service.yaml
kubectl apply -f gitea-ingress.yaml


## edit /etc/hosts file
<minikube ip address> gitea.bansikah.com

##verify deployemts
kubectl get pods
kubectl get deployment
kubectl get ingress
kubectl get service
```
Access through https://gitea.bansikah.com