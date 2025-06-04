# Kubernetes Ingress

This directory demonstrates how to use Ingress in Kubernetes for managing external access to services in a cluster.

## What is Ingress?

An Ingress is an API object that manages external access to services in a cluster, typically HTTP. Ingress can provide:
- Load balancing
- SSL termination
- Name-based virtual hosting
- Path-based routing

## Prerequisites

1. Install an Ingress Controller (example using NGINX):
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml
```

2. Wait for the Ingress Controller to be ready:
```bash
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s
```

## Testing Ingress

1. Create sample applications and services:
```yaml
# app1.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app1
spec:
  replicas: 2
  selector:
    matchLabels:
      app: app1
  template:
    metadata:
      labels:
        app: app1
    spec:
      containers:
      - name: app1
        image: nginx
---
apiVersion: v1
kind: Service
metadata:
  name: app1-service
spec:
  selector:
    app: app1
  ports:
  - port: 80
    targetPort: 80
```

2. Apply the Ingress configuration:
```bash
kubectl apply -f ingress.yaml
```

3. Verify the Ingress:
```bash
kubectl get ingress
kubectl describe ingress example-ingress
```

4. Add DNS entry (for local testing, add to /etc/hosts):
```bash
echo "$(minikube ip) myapp.example.com" | sudo tee -a /etc/hosts
```

5. Test the Ingress:
```bash
curl -H "Host: myapp.example.com" http://$(minikube ip)/app1
curl -H "Host: myapp.example.com" http://$(minikube ip)/app2
```

## SSL/TLS Configuration

1. Create a TLS secret:
```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout tls.key -out tls.crt -subj "/CN=myapp.example.com"
kubectl create secret tls tls-secret --key tls.key --cert tls.crt
```

2. The Ingress is already configured to use this secret in the TLS section.

## Best Practices

1. Always use HTTPS/TLS for production
2. Implement rate limiting when needed
3. Configure proper health checks
4. Use appropriate annotations for your Ingress controller
5. Monitor Ingress controller metrics

## Cleanup

```bash
kubectl delete ingress example-ingress
kubectl delete secret tls-secret
# Remove the host entry if added
sudo sed -i '/myapp.example.com/d' /etc/hosts
```
