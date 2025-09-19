Day 60: Persistent Volumes in Kubernetes

>You are never too old to set another goal or to dream a new dream.
>
>– Malala Yousafzai

>In learning you will teach, and in teaching you will learn.
>
>– Phil Collins

The Nautilus DevOps team is working on a Kubernetes template to deploy a web application on the cluster. There are some requirements to create/use persistent volumes to store the application code, and the template needs to be designed accordingly. Please find more details below:


1. Create a `PersistentVolume` named as `pv-nautilus`. Configure the spec as storage class should be manual, set capacity to `5Gi`, set access mode to ReadWriteOnce, volume type should be `hostPath` and set path to `/mnt/data` (this directory is already created, you might not be able to access it directly, so you need not to worry about it).

2. Create a `PersistentVolumeClaim` named as `pvc-nautilus`. Configure the `spec` as storage class should be `manual`, request `2Gi` of the storage, set access mode to `ReadWriteOnce`.

3. Create a `pod` named as `pod-nautilus`, mount the persistent volume you created with claim name `pvc-nautilus` at document root of the web server, the container within the pod should be named as `container-nautilus` using image nginx with latest tag only (remember to mention the tag i.e `nginx:latest`).

4. Create a `node port` type service named `web-nautilus` using node port `30008` to expose the web server running within the pod.

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution

```bash
# 0) Clean up any previous resources (in case you you had some things deployed already)
kubectl delete svc web-nautilus --ignore-not-found
kubectl delete pod pod-nautilus --ignore-not-found
kubectl delete pvc pvc-nautilus --ignore-not-found
kubectl delete pv pv-nautilus --ignore-not-found

# 1) Create a combined manifest for all resources (with initContainer to create index.html)
cat <<'EOF' > day60-all.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-nautilus
spec:
  storageClassName: manual
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-nautilus
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
---
apiVersion: v1
kind: Pod
metadata:
  name: pod-nautilus
  labels:
    app: nautilus-web
spec:
  initContainers:
    - name: init-index
      image: busybox
      command: ['sh', '-c', 'echo Hello from Nautilus! > /mnt/index.html']
      volumeMounts:
        - name: nautilus-storage
          mountPath: /mnt
  containers:
    - name: container-nautilus
      image: nginx:latest
      volumeMounts:
        - mountPath: /usr/share/nginx/html
          name: nautilus-storage
  volumes:
    - name: nautilus-storage
      persistentVolumeClaim:
        claimName: pvc-nautilus
---
apiVersion: v1
kind: Service
metadata:
  name: web-nautilus
spec:
  type: NodePort
  selector:
    app: nautilus-web
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30008
EOF

# 2) Apply the manifest
kubectl apply -f day60-all.yaml

# 3) Verify resources
kubectl get pv pv-nautilus
kubectl get pvc pvc-nautilus
kubectl get pod pod-nautilus
kubectl get svc web-nautilus

# 4) Access the web server in your browser using:
# http://<NodeIP>:30008
# or in your lab: https://30008-port-<your-lab-id>.labs.kodekloud.com/
```




