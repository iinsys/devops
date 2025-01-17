# Kubernetes Pods

A **Pod** is the smallest and simplest unit in the Kubernetes object model. It represents a single instance of a running process in a Kubernetes cluster. Pods can contain one or more tightly coupled containers that share the same network namespace, storage, and lifecycle.

## Key Features:
- **Multi-Container Support**: Pods can run multiple containers, which share storage volumes and the network.
- **Shared Network**: Containers in a pod share the same IP address and port space.
- **Ephemeral**: Pods are designed to be ephemeral; they can be replaced by new ones when needed.

## Lifecycle of a Pod:
1. **Pending**: Pod is created but waiting for resources or scheduling.
2. **Running**: Pod is bound to a node and containers are running.
3. **Succeeded/Failed**: Pod has completed or terminated.

## Example: Creating a Pod
Below is an example YAML file to create a pod:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
  labels:
    app: my-app
spec:
  containers:
    - name: my-container
      image: nginx:latest
      ports:
        - containerPort: 80
```
## commands to us
```bash
kubectl apply -f pod.yaml

## verify pod deployment
kubectl get pods
## see information about the pod
kubectl describe pod my-pod

## Access pod
kubectl exec -it my-pod -- /bin/bash

### forward pod
kubectl port-forward pod/my-pod 8080:80
```