Day 66: Deploy MySQL on Kubernetes

>You are never too old to set another goal or to dream a new dream.
>
>– Malala Yousafzai

A new MySQL server needs to be deployed on Kubernetes cluster. The Nautilus DevOps team was working on to gather the requirements. Recently they were able to finalize the requirements and shared them with the team members to start working on it. Below you can find the details:



1.) Create a `PersistentVolume` mysql-pv, its capacity should be `250Mi`, set other parameters as per your preference.


2.) Create a `PersistentVolumeClaim` to request this `PersistentVolume` storage. Name it as `mysql-pv-claim` and request a `250Mi` of storage. Set other parameters as per your preference.


3.) Create a deployment named `mysql-deployment`, use any mysql image as per your preference. Mount the `PersistentVolume` at mount path `/var/lib/mysql`.


4.) Create a `NodePort` type service named `mysql` and set `nodePort` to `30007`.


5.) Create a secret named `mysql-root-pass` having a key pair value, where key is password and its value is `YUIidhb667`, create another `secret` named `mysql-user-pass` having some key pair values, where frist key is username and its value is `kodekloud_joy`, second key is password and value is `8FmzjvFU6S`, create one more secret named `mysql-db-url`, key name is database and value is `kodekloud_db7`


6.) Define some `Environment` variables within the container:


a) `name: MYSQL_ROOT_PASSWORD`, should pick value from `secretKeyRef name: mysql-root-pass` and `key: password`


b) `name: MYSQL_DATABASE`, should pick value from `secretKeyRef name: mysql-db-url` and `key: database`


c) `name: MYSQL_USER`, should pick value from` secretKeyRef name: mysql-user-pass` key `key: username`


d) `name: MYSQL_PASSWORD,` should pick value from `secretKeyRef name: mysql-user-pass` and `key: password`


`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
vi mysql-setup.yaml

## inside the mysql-setup.yaml
---
# 1. PersistentVolume
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mysql-pv
spec:
  capacity:
    storage: 250Mi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /mnt/data/mysql
---
# 2. PersistentVolumeClaim
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-pv-claim
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 250Mi
---
# 5. Secrets
apiVersion: v1
kind: Secret
metadata:
  name: mysql-root-pass
type: Opaque
stringData:
  password: YUIidhb667
---
apiVersion: v1
kind: Secret
metadata:
  name: mysql-user-pass
type: Opaque
stringData:
  username: kodekloud_joy
  password: 8FmzjvFU6S
---
apiVersion: v1
kind: Secret
metadata:
  name: mysql-db-url
type: Opaque
stringData:
  database: kodekloud_db7
---
# 3. Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
        - name: mysql-container
          image: mysql:5.7
          ports:
            - containerPort: 3306
          env:
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: mysql-root-pass
                  key: password
            - name: MYSQL_DATABASE
              valueFrom:
                secretKeyRef:
                  name: mysql-db-url
                  key: database
            - name: MYSQL_USER
              valueFrom:
                secretKeyRef:
                  name: mysql-user-pass
                  key: username
            - name: MYSQL_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: mysql-user-pass
                  key: password
          volumeMounts:
            - name: mysql-storage
              mountPath: /var/lib/mysql
      volumes:
        - name: mysql-storage
          persistentVolumeClaim:
            claimName: mysql-pv-claim
---
# 4. Service
apiVersion: v1
kind: Service
metadata:
  name: mysql
spec:
  type: NodePort
  selector:
    app: mysql
  ports:
    - port: 3306
      targetPort: 3306
      nodePort: 30007


## Verification
# 1. Check PV and PVC status
kubectl get pv mysql-pv
kubectl get pvc mysql-pv-claim

# 2. Check Deployment rollout
kubectl rollout status deployment/mysql-deployment

# 3. Get Pod details
kubectl get pods -l app=mysql -o wide

# 4. Check Service exposure (NodePort 30007 → 3306)
kubectl describe svc mysql

# 5. Exec into pod and test MySQL env vars
POD=$(kubectl get pods -l app=mysql -o jsonpath='{.items[0].metadata.name}')
kubectl exec -it $POD -- env | grep MYSQL_

# 6. Connect to MySQL inside the pod
kubectl exec -it $POD -- mysql -u kodekloud_joy -p8FmzjvFU6S -e "SHOW DATABASES;"

```




