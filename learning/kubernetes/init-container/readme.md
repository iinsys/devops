# Init Containers in Kubernetes

This directory demonstrates how to use Init Containers to perform startup tasks before the main application container runs.

## What are Init Containers?

Init Containers are specialized containers that run before app containers in a Pod. They must complete successfully before the app containers can start. Common uses include:
- Setup scripts
- Waiting for dependencies
- Initializing configuration

## Testing with Minikube

1. Start Minikube:
```bash
minikube start
```

2. Deploy the application:
```bash
kubectl apply -f init-deployment.yaml
```

3. Watch the pods:
```bash
kubectl get pods -w
```

You'll see the init containers running sequentially before the main container starts.

4. Check init container logs:
```bash
# Get the pod name
POD_NAME=$(kubectl get pod -l app=web-app -o jsonpath='{.items[0].metadata.name}')

# Check logs of first init container
kubectl logs $POD_NAME -c wait-for-db

# Check logs of second init container
kubectl logs $POD_NAME -c init-db
```

5. Verify the database was initialized:
```bash
# Get MySQL pod name
MYSQL_POD=$(kubectl get pod -l app=mysql -o jsonpath='{.items[0].metadata.name}')

# Check if database exists
kubectl exec $MYSQL_POD -- mysql -uroot -ppassword123 -e "SHOW DATABASES;"
```

6. Test failure scenario:
```bash
# Delete MySQL service
kubectl delete service mysql

# Deploy a new web-app pod
kubectl scale deployment web-app --replicas=0
kubectl scale deployment web-app --replicas=1

# Watch the init container wait
kubectl get pods -w
```

7. Fix the scenario:
```bash
# Recreate MySQL service
kubectl apply -f init-deployment.yaml
```

## Common Use Cases

1. **Service Dependencies**
   - Waiting for databases
   - Checking external services
   - DNS resolution checks

2. **Volume Setup**
   - Populating data
   - Setting permissions
   - Creating directories

3. **Configuration**
   - Generating configs
   - Fetching secrets
   - Environment setup

## Best Practices

1. Keep init containers lightweight
2. Use proper health checks
3. Handle failures gracefully
4. Set appropriate resource requests/limits
5. Use minimal images (like busybox) when possible

## Cleanup

```bash
kubectl delete -f init-deployment.yaml
```
