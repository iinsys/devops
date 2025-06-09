# RBAC (Role-Based Access Control) in Kubernetes

Role-Based Access Control (RBAC) is a method of regulating access to Kubernetes resources based on the roles of individual users or service accounts within your cluster. RBAC lets you define who can do what, where, and on which resources.

## What is a ServiceAccount?
A **ServiceAccount** is an account for processes running in pods. It provides an identity for processes that run in a Pod, allowing them to interact with the Kubernetes API securely. By default, every pod gets a default service account, but you can create custom ones for finer-grained access control.

- **Use cases:**
  - Granting pods access to specific resources (e.g., only list pods, not delete them)
  - Integrating with CI/CD pipelines or external systems

## How RBAC Works
RBAC uses four main Kubernetes resources:
- **Role**: Defines a set of permissions (verbs) within a namespace.
- **ClusterRole**: Like Role, but cluster-wide.
- **RoleBinding**: Grants the permissions defined in a Role to a user, group, or service account within a namespace.
- **ClusterRoleBinding**: Like RoleBinding, but cluster-wide.

**Example Flow:**
1. Create a Role that allows listing pods in a namespace.
2. Create a ServiceAccount for your app.
3. Create a RoleBinding to bind the Role to the ServiceAccount.
4. Use the ServiceAccount in your pod spec.

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
kubectl apply -f rbac-test.yaml

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
