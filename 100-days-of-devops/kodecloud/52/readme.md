Day 52: Revert Deployment to Previous Version in Kubernetes

>Excellence happens not by accident. It is a process.
>
>– Dr. APJ. Abdul Kalam

Earlier today, the Nautilus DevOps team deployed a new release for an application. However, a customer has reported a bug related to this recent release. Consequently, the team aims to revert to the previous version.


There exists a deployment named `nginx-deployment`; initiate a rollback to the previous revision.

`Note:` The `kubectl` utility on `jump_host` is configured to interact with the Kubernetes cluster.

## Solution
```bash
# Rollback the deployment to the previous revision
kubectl rollout undo deployment/nginx-deployment

# Verify rollout status
kubectl rollout status deployment/nginx-deployment

# Confirm pods are running
kubectl get pods

```



