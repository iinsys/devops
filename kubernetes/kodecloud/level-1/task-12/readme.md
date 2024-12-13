An application deployed on the Kubernetes cluster requires an update with new features developed by the Nautilus application development team. The existing setup includes a deployment named nginx-deployment and a service named nginx-service. Below are the necessary changes to be implemented without deleting the deployment and service:


1.) Modify the service nodeport from 30008 to 32165

2.) Change the replicas count from 1 to 5

3.) Update the image from nginx:1.18 to nginx:latest

Note: The kubectl utility on jump_host is configured to operate with the Kubernetes cluster.


#### Solution
```bash
kubectl edit service nginx-service


##Alternatively
kubectl patch service nginx-service \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/ports/0/nodePort", "value": 32165}]'


##2
kubectl scale deployment nginx-deployment --replicas=5

##lastes
kubectl set image deployment/nginx-deployment nginx-container=nginx:latest
###Verify deployment
kubectl get deployment nginx-deployment -o wide
kubectl get pods -o wide

```

