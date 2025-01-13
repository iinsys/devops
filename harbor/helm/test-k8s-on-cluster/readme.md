kubectl create secret docker-registry harbor-registry-secret \
  --docker-server=core.harbor.bansikah.com \
  --docker-username=admin \
  --docker-password="Harbor12345" \
  --docker-email=your-email@example.com


kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml
kubectl get pods
