Last week, the Nautilus DevOps team deployed a redis app on Kubernetes cluster, which was working fine so far. This morning one of the team members was making some changes in this existing setup, but he made some mistakes and the app went down. We need to fix this as soon as possible. Please take a look.

The deployment name is `redis-deployment`. The pods are not in running state right now, so please look into the issue and fix the same.


`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
## first of all verify deployments and describe the pod to see the status
kubectl get deployments
kubectl get pods
kubectl describe pod <pod-name-with id>
## configmap has an issue
kubectl get configmaps
kubectl edit deployment redis-deployment
## find this and correct the spelling
volumes:
  - name: config
    configMap:
      name: redis-config # Correct name here

## restart deployment
kubectl rollout restart deployment redis-deployment
## verify pod status
kubectl get pods -w

## second issue
kubectl describe deployment redis-deployment
## edit this 
Containers:
  redis-container:
    Image: redis:alpin

# so correct spelling
kubectl edit deployment redis-deployment
## change to 
image: redis:alpine

kubectl rollout restart deployment redis-deployment

kubectl get pods -w

## final verification
kubectl logs -l app=redis

# and check task if you passed

```