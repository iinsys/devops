# Kubernetes Resource Quotas

This directory demonstrates how to use Resource Quotas in Kubernetes to limit resource consumption in a namespace.

## What is a Resource Quota?

A **ResourceQuota** is a Kubernetes object that places constraints on the total amount of compute resources (like CPU and memory) or object counts (like pods or services) that can be consumed in a specific namespace. It helps enforce **fair usage policies** and **prevent resource exhaustion** in shared clusters by:

- Limiting the number of Kubernetes objects (pods, services, etc.)
- Capping the aggregate resource requests or limits (CPU, memory, etc.)
- Ensuring workloads stay within defined boundaries

## Types of Quotas

1. **Compute Quotas**
   - CPU requests and limits
   - Memory requests and limits
   - Number of pods

2. **Object Quotas**
   - Number of ConfigMaps
   - Number of PersistentVolumeClaims
   - Number of Services
   - Number of Secrets

## Testing with Minikube

1. Start Minikube:
```bash
minikube start
```

2. Create a test namespace:
```bash
kubectl create namespace quota-test
```

3. Apply the resource quotas to the namespace:
```bash
kubectl apply -f quota.yaml -n quota-test
```

4. Verify the quotas:
```bash
kubectl describe resourcequota -n quota-test
```

5. Deploy the test application:
```bash
kubectl apply -f test-deployment.yaml -n quota-test
```

6. Watch the deployment and pods:
```bash
kubectl get deployment -n quota-test -w
kubectl get pods -n quota-test -w
```

7. Check quota usage:
```bash
kubectl describe resourcequota compute-quota -n quota-test
###
kubectl describe resourcequota object-quota -n quota-test
```

8. Test quota limits:
```bash
# Try to scale beyond quota
kubectl scale deployment quota-test-app -n quota-test --replicas=10

# Check events for quota violation
kubectl get events -n quota-test
```
When you try the above you should get `errors` related to the scaling limits and resource quoatas

9. Test with a pod that exceeds quota:
```bash
cat <<EOF | kubectl apply -f - -n quota-test
apiVersion: v1
kind: Pod
metadata:
  name: huge-pod
spec:
  containers:
  - name: nginx
    image: nginx:alpine
    resources:
      requests:
        memory: "3Gi"
        cpu: "3"
      limits:
        memory: "4Gi"
        cpu: "4"
EOF
```
When you try the above you should get `errors` related to the scaling limits and resource quoatas

## Cleanup

```bash
kubectl delete namespace quota-test
```

## Best Practices

1. Always set resource requests and limits for containers
2. Use namespaces to isolate workloads
3. Monitor quota usage regularly
4. Plan quota values based on actual needs
5. Consider using LimitRanges with ResourceQuotas
