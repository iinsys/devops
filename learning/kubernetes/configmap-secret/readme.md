# ConfigMaps and Secrets in Kubernetes

This directory demonstrates how to work with ConfigMaps and Secrets in Kubernetes for managing configuration and sensitive data.

## Testing with Minikube

1. Start Minikube:
```bash
minikube start
```

2. Create ConfigMap and Secret:
```bash
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
```

3. Deploy the test application:
```bash
kubectl apply -f app-deployment.yaml
```

4. Verify the deployment:
```bash
kubectl get pods
kubectl get configmap
kubectl get secret
```

5. Test the configuration:
```bash
# Get the pod name
export POD_NAME=$(kubectl get pods -l app=config-test -o jsonpath="{.items[0].metadata.name}")

# Check environment variables
kubectl exec $POD_NAME -- env | grep APP_COLOR
kubectl exec $POD_NAME -- env | grep DB_USER

# Check mounted config file
kubectl exec $POD_NAME -- cat /usr/share/nginx/html/index.html
```

6. Access the application:
```bash
kubectl port-forward $POD_NAME 8080:80
```
Now visit http://localhost:8080 in your browser

## ConfigMaps

ConfigMaps allow you to decouple configuration artifacts from image content to keep containerized applications portable.

### Testing ConfigMaps

1. Create the ConfigMap:
```bash
kubectl apply -f configmap.yaml
```

2. Verify the ConfigMap:
```bash
kubectl get configmap app-config
kubectl describe configmap app-config
```

3. Using ConfigMap in a Pod (example):
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  containers:
  - name: test-container
    image: nginx
    env:
    - name: APP_COLOR
      valueFrom:
        configMapKeyRef:
          name: app-config
          key: APP_COLOR
    volumeMounts:
    - name: config-volume
      mountPath: /etc/config
  volumes:
  - name: config-volume
    configMap:
      name: app-config
```

## Secrets

Secrets let you store and manage sensitive information, such as passwords, OAuth tokens, and ssh keys.

### Testing Secrets

1. Create the Secret:
```bash
kubectl apply -f secret.yaml
```

2. Verify the Secret:
```bash
kubectl get secret app-secret
kubectl describe secret app-secret
```

3. Using Secret in a Pod (example):
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  containers:
  - name: test-container
    image: nginx
    env:
    - name: DATABASE_USER
      valueFrom:
        secretKeyRef:
          name: app-secret
          key: DB_USER
    - name: DATABASE_PASSWORD
      valueFrom:
        secretKeyRef:
          name: app-secret
          key: DB_PASS
```

## Best Practices

1. Don't commit secrets to version control
2. Use environment-specific ConfigMaps
3. Consider using external secret management systems
4. Regularly rotate secrets
5. Use RBAC to control access to ConfigMaps and Secrets

## Cleanup

```bash
kubectl delete configmap app-config
kubectl delete secret app-secret
```
