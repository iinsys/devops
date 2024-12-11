# StatefulSets in Kubernetes

1. **Purpose**:
   - Manages stateful applications.
   - Ensures each Pod has a stable identity, storage, and networking.

2. **Pod Identity**:
   - Pods are named sequentially (e.g., `app-0`, `app-1`).
   - Deletion and recreation preserve the same identity.

3. **Storage**:
   - Uses PersistentVolumeClaims (PVCs) for stable storage.
   - Each Pod gets a unique PVC that persists data across restarts.

4. **Scaling**:
   - Pods are created and terminated sequentially (e.g., `app-0` before `app-1`).

5. **Use Cases**:
   - Databases (e.g., MySQL, PostgreSQL).
   - Distributed systems (e.g., Kafka, ZooKeeper).
   - Applications needing fixed Pod names or stable storage.

6. **Components**:
   - **StatefulSet**: Defines and manages stateful Pods.
   - **Headless Service**: Provides DNS names for Pods (e.g., `app-0.service-name`).

7. **Commands**:
   - Create a StatefulSet:
     ```bash
     kubectl apply -f statefulset.yaml
     ```
   - Check StatefulSets:
     ```bash
     kubectl get statefulsets
     ```
   - Delete a StatefulSet (data persists unless PVCs are deleted):
     ```bash
     kubectl delete statefulset <name>
     ```

8. **Key Differences from Deployments**:
   - Deployments are for stateless apps, while StatefulSets ensure state persistence.
   - StatefulSets guarantee order in Pod creation, deletion, and updates.

### Example usage
```bash
kubectl apply -f mysql-pvc.yaml
kubectl apply -f mysql-statefulset.yaml
### verify deployment
kubectl get pods
### Access specific pod
kubectl exec -it mysql-0 -- bash
###inside the pod
mysql -u root -p
# Enter the root password (rootpassword)


### Scaling up and down to test behaviour
kubectl scale statefulset mysql --replicas=1
kubectl scale statefulset mysql --replicas=3


## Verify that pod retains persistent volume
kubectl exec -it mysql-0 -- bash
ls /var/lib/mysql


##pod recreation
kubectl delete pod mysql-1
kubectl get pods

##clean up
kubectl delete -f mysql-statefulset.yaml
kubectl delete pvc -l app=mysql

```