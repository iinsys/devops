An application currently running on the Kubernetes cluster employs the nginx web server. The Nautilus application development team has introduced some recent changes that need deployment. They've crafted an image nginx:1.18 with the latest updates.


Execute a rolling update for this application, integrating the nginx:1.18 image. The deployment is named nginx-deployment.

Ensure all pods are operational post-update.

Note: The kubectl utility on jump_host is set up to operate with the Kubernetes cluster

Solution:
```bash
# Update the deployment using the proper container name (nginx-container):
kubectl set image deployment/nginx-deployment nginx-container=nginx:1.18
```
#### Steps to Verify the Update
```bash
#Check the Rollout Status
#Ensure the deployment is rolling out successfully:
kubectl rollout status deployment/nginx-deployment

# Verify the Pods
# Check if new pods are running:
kubectl get pods -o wide

# Confirm the Updated Image
# Confirm the deployment has the new image:
kubectl describe deployment nginx-deployment | grep Image

```
