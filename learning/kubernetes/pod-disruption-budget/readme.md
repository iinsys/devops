# Pod Disruption Budgets (PDB)


**Definition:**  
A **Pod Disruption Budget (PDB)** is a Kubernetes policy object that ensures a minimum number of pods in a deployment, stateful set, or replica set remain available during **voluntary disruptions** (e.g., node maintenance, cluster upgrades). PDBs prevent too many pods from being evicted at once, helping maintain application availability.


This directory demonstrates how to use PodDisruptionBudgets to ensure high availability during voluntary disruptions.

## Testing with Minikube

1. Start Minikube with multiple nodes (optional, but recommended):
```bash
minikube start --nodes 2
```

2. Deploy the high-availability application:
```bash
kubectl apply -f ha-deployment.yaml
```

3. Verify the deployment:
```bash
kubectl get deployment,pods,svc
```

4. Apply the PodDisruptionBudget:
```bash
kubectl apply -f pdb.yaml
```

5. Verify the PDB:
```bash
kubectl get pdb
kubectl describe pdb app-pdb
```

6. Test the PDB:
```bash
# Try to drain a node (this simulates maintenance)
NODE=$(kubectl get nodes --no-headers | grep -v control-plane | head -n 1 | awk '{print $1}')
kubectl drain $NODE --ignore-daemonsets --delete-emptydir-data

# Watch the pods
kubectl get pods -w

# Check PDB status during drain
kubectl describe pdb app-pdb
```

7. Test pod eviction:
```bash
# Try to manually evict pods
kubectl get pod -l app=ha-app -o jsonpath='{.items[0].metadata.name}'

## Delete pod
kubectl delete pod <hpa-pod>


```

8. Uncordon the node:
```bash
NODE=$(kubectl get nodes --no-headers | grep -v control-plane | awk '{print $1}')

## see node
echo $NODE

kubectl uncordon $NODE

```

## Types of PDB Specifications

1. **minAvailable**: Minimum number of pods that must be available
   ```yaml
   spec:
     minAvailable: 2  # or "50%"
   ```

2. **maxUnavailable**: Maximum number of pods that can be unavailable
   ```yaml
   spec:
     maxUnavailable: 1  # or "25%"
   ```

## Best Practices

1. Use percentages for dynamic scaling
2. Consider application requirements
3. Test PDB behavior before production
4. Monitor PDB status during maintenance
5. Use with appropriate replica counts

## Cleanup

```bash
kubectl delete -f ha-deployment.yaml
kubectl delete -f pdb.yaml
```
