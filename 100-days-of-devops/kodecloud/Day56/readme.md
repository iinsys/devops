Day 56: Deploy Nginx Web Server on Kubernetes Cluster

>Excellence happens not by accident. It is a process.
>
>– Dr. APJ. Abdul Kalam

Some of the Nautilus team developers are developing a static website and they want to deploy it on Kubernetes cluster. They want it to be highly available and scalable. Therefore, based on the requirements, the DevOps team has decided to create a deployment for it with multiple replicas. Below you can find more details about it:


1. Create a `deployment` using `nginx` image with `latest` tag only and remember to mention the tag i.e `nginx:latest`. Name it as `nginx-deployment`. The container should be named as `nginx-container`, also make sure `replica` counts are `3`.

2. Create a `NodePort` type service named `nginx-service`. The nodePort should be `30011`.

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# 1) Create deployment + NodePort service manifest
cat <<'EOF' > nginx-deploy-svc.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx-container
          image: nginx:latest
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30011
EOF

# 2) Apply the manifest
kubectl apply -f nginx-deploy-svc.yaml

# 3) Verify deployment and pods
kubectl get deployment nginx-deployment
kubectl get pods -l app=nginx

# 4) Verify service and nodePort
kubectl get svc nginx-service -o wide
kubectl describe svc nginx-service

```