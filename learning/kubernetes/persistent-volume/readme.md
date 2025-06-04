# Kubernetes Persistent Volumes and Claims

This directory demonstrates how to work with Persistent Volumes (PV) and Persistent Volume Claims (PVC) in Kubernetes.

## Testing with Minikube

1. Start Minikube:
```bash
minikube start
```

2. Create PV and PVC:
```bash
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
```

3. Verify PV and PVC are bound:
```bash
kubectl get pv,pvc
```

4. Deploy MySQL with persistent storage:
```bash
kubectl apply -f mysql-deployment.yaml
```

5. Verify the deployment:
```bash
kubectl get pods
kubectl get svc
```

6. Test the persistent storage:
```bash
# Get the pod name
export POD_NAME=$(kubectl get pods -l app=mysql -o jsonpath="{.items[0].metadata.name}")

# Create a test database
kubectl exec -it $POD_NAME -- mysql -u root -ppassword123 -e "CREATE DATABASE persistent_test;"
kubectl exec -it $POD_NAME -- mysql -u root -ppassword123 -e "SHOW DATABASES;"

# Delete the pod (it will be recreated)
kubectl delete pod $POD_NAME

# Wait for new pod
sleep 30

# Get the new pod name
export POD_NAME=$(kubectl get pods -l app=mysql -o jsonpath="{.items[0].metadata.name}")

# Verify data persists
kubectl exec -it $POD_NAME -- mysql -u root -ppassword123 -e "SHOW DATABASES;"
```

## What are PV and PVC?

- **Persistent Volume (PV)**: A piece of storage in the cluster provisioned by an administrator or dynamically by Storage Classes.
- **Persistent Volume Claim (PVC)**: A request for storage by a user, which can be fulfilled by a PV.

## Prerequisites

1. A Kubernetes cluster (local or cloud)
2. Storage backend (local disk, cloud storage, NFS, etc.)

## Testing PV and PVC

1. Create the Persistent Volume:
```bash
kubectl apply -f pv.yaml
```

2. Verify PV creation:
```bash
kubectl get pv
kubectl describe pv example-pv
```

3. Create the Persistent Volume Claim:
```bash
kubectl apply -f pvc.yaml
```

4. Verify PVC creation and binding:
```bash
kubectl get pvc
kubectl describe pvc example-pvc
```

5. Use PVC in a Pod:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pv-pod
spec:
  containers:
  - name: test-container
    image: nginx
    volumeMounts:
    - mountPath: "/usr/share/nginx/html"
      name: test-volume
  volumes:
  - name: test-volume
    persistentVolumeClaim:
      claimName: example-pvc
```

6. Test the storage:
```bash
# Create test pod
kubectl apply -f test-pod.yaml

# Write data
kubectl exec test-pv-pod -- sh -c "echo 'Hello from PV' > /usr/share/nginx/html/index.html"

# Read data
kubectl exec test-pv-pod -- cat /usr/share/nginx/html/index.html
```

## Storage Classes

StorageClasses enable dynamic provisioning of PVs. Example StorageClass:

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast
provisioner: kubernetes.io/gce-pd  # Change based on your environment
parameters:
  type: pd-ssd
```

## Access Modes

1. **ReadWriteOnce (RWO)**: Volume can be mounted as read-write by a single node
2. **ReadOnlyMany (ROX)**: Volume can be mounted read-only by many nodes
3. **ReadWriteMany (RWX)**: Volume can be mounted as read-write by many nodes

## Reclaim Policies

1. **Retain**: Manual reclamation
2. **Delete**: Automatically delete PV and storage
3. **Recycle**: Basic scrub (deprecated)

## Best Practices

1. Use StorageClasses for dynamic provisioning
2. Set appropriate access modes
3. Consider backup strategies
4. Monitor storage usage
5. Use appropriate reclaim policies

## Cleanup

```bash
# Delete test pod
kubectl delete pod test-pv-pod

# Delete PVC
kubectl delete pvc example-pvc

# Delete PV
kubectl delete pv example-pv
```
