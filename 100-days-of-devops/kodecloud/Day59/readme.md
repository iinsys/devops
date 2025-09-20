Day 59: Troubleshoot Deployment issues in Kubernetes

>Neither comprehension nor learning can take place in an atmosphere of anxiety.
>
>– Rose Kennedy

Last week, the Nautilus DevOps team deployed a redis app on Kubernetes cluster, which was working fine so far. This morning one of the team members was making some changes in this existing setup, but he made some mistakes and the app went down. We need to fix this as soon as possible. Please take a look.



- The deployment name is `redis-deployment`. The pods are not in running state right now, so please look into the issue and fix the same.


`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# 1. Check the failing pod and describe it to find issues
kubectl get pods -l app=redis
kubectl describe pod -l app=redis

# 2. Fix the wrong ConfigMap name in the Deployment (from redis-cofig → redis-config)
kubectl edit deployment redis-deployment
# → update the volume ConfigMap reference to: name: redis-config

# 3. Fix the wrong image name (from redis:alpin → redis:alpine)
kubectl set image deployment/redis-deployment redis-container=redis:alpine

# 4. Verify rollout and pod status
kubectl rollout status deployment/redis-deployment
kubectl get pods -l app=redis -w

```
`Note`: The error might always change based on the task but always try to describe the pods and deployment to see where the issue is