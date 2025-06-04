# RBAC Testing with Minikube

This example demonstrates Role-Based Access Control (RBAC) in Kubernetes.

## Prerequisites
- Minikube cluster running
- kubectl configured

## Testing Steps

1. Create the RBAC resources:
```bash
kubectl apply -f service-account.yaml
kubectl apply -f role.yaml
kubectl apply -f role-binding.yaml
```

2. Create a test pod:
```bash
kubectl run nginx --image=nginx:alpine
```

3. Test the ServiceAccount permissions:
```bash
# Create a pod that uses the ServiceAccount
kubectl run rbac-test --image=bitnami/kubectl --serviceaccount=pod-reader-account \
  --command -- sleep infinity

# Test listing pods (should work)
kubectl exec -it rbac-test -- kubectl get pods

# Test listing services (should fail)
kubectl exec -it rbac-test -- kubectl get services
```

## Cleanup
```bash
kubectl delete -f .
kubectl delete pod nginx rbac-test
```

## Expected Results
- The pod using pod-reader-account should be able to list pods
- It should NOT be able to list services or other resources
