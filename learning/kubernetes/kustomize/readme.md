# Nginx Kustomize Demo

This is a simple demo project using **Kustomize** to deploy an Nginx application in Kubernetes with a Deployment, Service, and Ingress.

## 📂 Files
- `kustomization.yaml` – Kustomize entrypoint
- `nginx-depl.yaml` – Nginx Deployment (2 replicas)
- `nginx-service.yaml` – ClusterIP Service for Nginx
- `nginx-ingress.yaml` – Ingress resource with optional TLS (commented out)

## 🚀 Steps to Deploy

### 1. Apply Kustomize
```sh
kubectl apply -k .

## verification
kubectl get pods
kubectl get svc
kubectl get ingress

# Add this line to your /etc/hosts (Linux/Mac)
minikube ip ## to get minikube ip address

<minikube ip address>   nginx.example.com

# Access on the browser
nginx.example.com


