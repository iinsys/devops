Day 49: Deploy Applications with Kubernetes Deployments

>In learning you will teach, and in teaching you will learn.
>
>– Phil Collins

The Nautilus DevOps team is delving into Kubernetes for app management. One team member needs to create a deployment following these details:


1. Create a deployment named `nginx` to deploy the application nginx using the image `nginx:latest` (ensure to specify the tag)

`Note:` The `kubectl` utility on `jump_host` is set up to interact with the Kubernetes cluster.

## Solution
```bash
# --- Imperative Command ---
kubectl create deployment nginx --image=nginx:latest

# Verify deployment
kubectl get deployments
kubectl get pods -l app=nginx

# --- OR Generate YAML from command ) ---
kubectl create deployment nginx --image=nginx:latest -o yaml --dry-run=client > nginx-deploy.yaml

# --- OR Manually write the file YAML File (nginx-deploy.yaml) ---
cat <<EOF > nginx-deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
EOF

# Apply the YAML
kubectl apply -f nginx-deploy.yaml

# Verify again
kubectl get deployments
kubectl get pods -l app=nginx

```