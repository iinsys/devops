### ReplicaSets
- Ensures that we always have a desired set of pods running in the cluster
- Tracks pods by using labels and selectors
- Label: key value pairs used to identify the pods
- If a pod dies or is deleted it is been recreated
- ReplicaSet is of object type `ReplicaSet`
- Destroys pods that is created manually, which is more than desired state


### commands to use
```bash
kubectl get replicasets
kubectl delete rs <replicasetname>
```

### Example nodejs application
```bash
kubectl apply -f nodejs-config.yaml
kubectl apply -f replicaset.yaml
kubectl get rs
kubectl get pods
kubectl delete pod <pod-name>
```