# Pod Affinity and Anti-Affinity in Kubernetes

This directory demonstrates how to use Pod Affinity and Anti-Affinity rules to control pod placement in your cluster.

## Testing with Minikube

1. Start Minikube with multiple nodes:
```bash
minikube start --nodes 3
```

2. Label the nodes:
```bash
# Label nodes for zone simulation
kubectl label nodes minikube zone=zone1
kubectl label nodes minikube-m02 zone=zone2
kubectl label nodes minikube-m03 zone=zone3
```

3. Deploy the applications:
```bash
kubectl apply -f affinity-deployment.yaml
```

4. Check pod distribution:
```bash
# See which nodes pods are scheduled on
kubectl get pods -o wide

# Should see web-app pods distributed across nodes
# Redis pods should be co-located with web-app pods
```

5. Test scaling:
```bash
# Scale web-app
kubectl scale deployment web-app --replicas=6

# Check new pod placement
kubectl get pods -o wide
```

6. Force pod rescheduling:
```bash
# Delete some pods and watch recreation
kubectl delete pod -l app=web-app
kubectl get pods -o wide -w
```

## Types of Affinities

1. **Pod Affinity**
   - Attracts pods to nodes running specific pods
   ```yaml
   podAffinity:
     requiredDuringSchedulingIgnoredDuringExecution:
     - labelSelector:
         matchExpressions:
         - key: app
           operator: In
           values:
           - cache
       topologyKey: kubernetes.io/hostname
   ```

2. **Pod Anti-Affinity**
   - Repels pods from nodes running specific pods
   ```yaml
   podAntiAffinity:
     preferredDuringSchedulingIgnoredDuringExecution:
     - weight: 100
       podAffinityTerm:
         labelSelector:
           matchExpressions:
           - key: app
             operator: In
             values:
             - web-app
         topologyKey: kubernetes.io/hostname
   ```

3. **Node Affinity**
   - Attracts pods to nodes with specific labels
   ```yaml
   nodeAffinity:
     requiredDuringSchedulingIgnoredDuringExecution:
       nodeSelectorTerms:
       - matchExpressions:
         - key: zone
           operator: In
           values:
           - zone1
   ```

## Best Practices

1. Use soft anti-affinity for better scheduling flexibility
2. Consider topology key carefully
3. Test with node failures
4. Monitor scheduling decisions
5. Use appropriate weight values

## Cleanup

```bash
kubectl delete -f affinity-deployment.yaml
```
