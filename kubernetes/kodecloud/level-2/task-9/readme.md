The Nautilus development team has completed development of one of the node applications, which they are planning to deploy on a Kubernetes cluster. They recently had a meeting with the DevOps team to share their requirements. Based on that, the DevOps team has listed out the exact requirements to deploy the app. Find below more details:


1. Create a deployment using gcr.io/kodekloud/centos-ssh-enabled:node` image, replica count must be `2`.

2. Create a service to expose this app, the service type must be `NodePort,` targetPort must be `8080` and nodePort should be `30012`.

3. Make sure all the pods are in `Running` state after the deployment.

4. You can check the application by clicking on `NodeApp` button on top bar.


`You can use any labels as per your choice`.


`Note`: The kubectl on jump_host has been configured to work with the kubernetes cluster.

## Solution
```bash
## apply files
kubectl apply -f node-deployment.yaml
kubectl apply -f node-service.yaml

## verify
# Check deployment status
kubectl get deployments

# Check pod status
kubectl get pods

# Check service status
kubectl get svc

#Access application click the Node App, at the top of the bar
## or you can do 
kubectl get nodes -o wide
 #if you don't see it

 ## debug if needed
 # Describe deployment
kubectl describe deployment node-deployment

# Describe service
kubectl describe service node-service

```