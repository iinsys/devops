Day 51: Execute Rolling Updates in Kubernetes

>Whatever we believe about ourselves and our ability comes true for us.
>
>– Susan L. Taylor

>Keep your face always toward the sunshine, and shadows will fall behind you.
>
>– Walt Whitman

An application currently running on the Kubernetes cluster employs the nginx web server. The Nautilus application development team has introduced some recent changes that need deployment. They've crafted an image `nginx:1.17` with the latest updates.


- Execute a rolling update for this application, integrating the `nginx:1.17` image. The deployment is named `nginx-deployment`.

- Ensure all pods are operational post-update.

`Note:` The `kubectl` utility on `jump_host` is set up to operate with the Kubernetes cluster

## Solution
```bash
# --- Imperative way ---
# 1. Find the container name inside the deployment
kubectl get deployment nginx-deployment -o yaml | grep "name:"

# Suppose it's "nginx-container"
# 2. Update the image of the existing deployment
kubectl set image deployment/nginx-deployment \
  nginx-container=nginx:1.17

# 3. Verify rollout status
kubectl rollout status deployment/nginx-deployment

# 4. List pods to confirm new image is running
kubectl get pods -o wide


# --- Declarative way (YAML patch) ---
# 1. Export current deployment YAML
kubectl get deployment nginx-deployment -o yaml > nginx-deployment.yaml

# 2. Edit the image inside the container spec
# snippet:
# containers:
# - name: nginx-container
#   image: nginx:1.17

# 3. Apply the updated YAML
kubectl apply -f nginx-deployment.yaml

# 4. Verify rollout status again
kubectl rollout status deployment/nginx-deployment

```




