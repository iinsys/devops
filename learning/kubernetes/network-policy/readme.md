# Kubernetes Network Policies

This directory demonstrates how to use Network Policies in Kubernetes to control pod-to-pod communication.

## Testing with Minikube

1. Start Minikube with Calico CNI:
```bash
minikube start --network-plugin=cni --cni=calico
```

2. Deploy the test applications:
```bash
kubectl apply -f test-apps.yaml
```

3. Verify the deployments:
```bash
kubectl get pods,svc
```

4. Test connectivity before applying network policy:
```bash
# Get pod names
export FRONTEND_POD=$(kubectl get pod -l app=frontend -o jsonpath='{.items[0].metadata.name}')
export BACKEND_POD=$(kubectl get pod -l app=backend -o jsonpath='{.items[0].metadata.name}')

# Test connection from frontend to backend (should work)
kubectl exec $FRONTEND_POD -- wget -qO- http://backend-service:8080

# Test connection from backend to frontend (should work)
kubectl exec $BACKEND_POD -- wget -qO- http://frontend-service:80
```

5. Apply the network policy:
```bash
kubectl apply -f network-policy.yaml
```

6. Test connectivity after applying network policy:
```bash
# Test connection from frontend to backend (should still work)
kubectl exec $FRONTEND_POD -- wget -qO- http://backend-service:8080

# Test connection from backend to frontend (should fail)
kubectl exec $BACKEND_POD -- wget -qO- http://frontend-service:80
```

## What are Network Policies?

Network Policies are specifications of how groups of pods are allowed to communicate with each other and other network endpoints. They provide:
- Pod-level network isolation
- Ingress and egress traffic control
- Label-based selection of pods and namespaces

## Prerequisites

1. Ensure your cluster supports Network Policies:
   - Most cloud providers support them by default
   - For Minikube, start with CNI that supports Network Policies:
     ```bash
     minikube start --network-plugin=cni --cni=calico
     ```

## Testing Network Policies

1. Create test deployments:
```bash
# Create frontend deployment
kubectl create deployment frontend --image=nginx --port=80 --labels=app=frontend

# Create API gateway deployment
kubectl create deployment api-gateway --image=nginx --port=80 --labels=app=api-gateway

# Create backend deployment
kubectl create deployment backend --image=nginx --port=8080 --labels=app=backend
```

2. Apply the Network Policy:
```bash
kubectl apply -f network-policy.yaml
```

3. Verify the Network Policy:
```bash
kubectl get networkpolicy
kubectl describe networkpolicy frontend-policy
```

4. Test the policy:
```bash
# Get pod names
FRONTEND_POD=$(kubectl get pod -l app=frontend -o jsonpath='{.items[0].metadata.name}')
GATEWAY_POD=$(kubectl get pod -l app=api-gateway -o jsonpath='{.items[0].metadata.name}')
BACKEND_POD=$(kubectl get pod -l app=backend -o jsonpath='{.items[0].metadata.name}')

# Test allowed connections
kubectl exec $GATEWAY_POD -- curl -s frontend:80  # Should work
kubectl exec $FRONTEND_POD -- curl -s backend:8080  # Should work

# Test blocked connections
kubectl exec $BACKEND_POD -- curl -s frontend:80  # Should fail
```

## Network Policy Types

1. **Pod-level policies**: Control traffic between pods
2. **Namespace-level policies**: Control traffic between namespaces
3. **CIDR-based policies**: Control traffic from/to specific IP ranges
4. **Default deny policies**: Block all traffic unless explicitly allowed

## Best Practices

1. Start with a default deny policy
2. Use labels consistently
3. Test policies thoroughly before applying to production
4. Document allowed traffic patterns
5. Monitor blocked traffic

## Example Default Deny Policy

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
```

## Cleanup

```bash
# Delete network policy
kubectl delete networkpolicy frontend-policy

# Delete test deployments
kubectl delete deployment frontend api-gateway backend
```
