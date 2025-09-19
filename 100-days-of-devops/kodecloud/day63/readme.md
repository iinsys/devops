Day 63: Deploy Iron Gallery App on Kubernetes

>Don't just think, do.
>
>– Horace

There is an iron gallery app that the Nautilus DevOps team was developing. They have recently customized the app and are going to deploy the same on the Kubernetes cluster. Below you can find more details:

**1.** Create a namespace `iron-namespace-datacenter`.

**2.** Create a deployment `iron-gallery-deployment-datacenter` for iron gallery under the same namespace you created.
   - Labels `run` should be `iron-gallery`.
   - Replicas count should be `1`.
   - Selector's `matchLabels` `run` should be `iron-gallery`.
   - Template labels `run` should be `iron-gallery` under metadata.
   - The container should be named as `iron-gallery-container-datacenter`, use `kodekloud/irongallery:2.0` image (use exact image name / tag).
   - Resources limits for memory should be `100Mi` and for CPU should be `50m`.
   - First volumeMount name should be `config`, its mountPath should be `/usr/share/nginx/html/data`.
   - Second volumeMount name should be `images`, its mountPath should be `/usr/share/nginx/html/uploads`.
   - First volume name should be `config` and give it `emptyDir` and second volume name should be `images`, also give it `emptyDir`.

**3.** Create a deployment `iron-db-deployment-datacenter` for iron db under the same namespace.
   - Labels `db` should be `mariadb`.
   - Replicas count should be `1`.
   - Selector's `matchLabels` `db` should be `mariadb`.
   - Template labels `db` should be `mariadb` under metadata.
   - The container name should be `iron-db-container-datacenter`, use `kodekloud/irondb:2.0` image (use exact image name / tag).
   - Define environment, set `MYSQL_DATABASE` value to `database_host`, set `MYSQL_ROOT_PASSWORD` and `MYSQL_PASSWORD` to complex passwords, and `MYSQL_USER` to any custom user (except root).
   - Volume mount name should be `db` and its mountPath should be `/var/lib/mysql`. Volume name should be `db` and give it an `emptyDir`.

**4.** Create a service for iron db named `iron-db-service-datacenter` under the same namespace. Configure spec as selector's `db` should be `mariadb`. Protocol should be TCP, port and targetPort should be `3306` and its type should be `ClusterIP`.

**5.** Create a service for iron gallery named `iron-gallery-service-datacenter` under the same namespace. Configure spec as selector's `run` should be `iron-gallery`. Protocol should be TCP, port and targetPort should be `80`, nodePort should be `32678` and its type should be `NodePort`.

> **Note:**
> - We don't need to make connection b/w database and front-end now, if the installation page is coming up it should be enough for now.
> - The `kubectl` on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# 1) Create the namespace
kubectl create namespace iron-namespace-datacenter

# 2) Create the iron gallery deployment manifest
cat <<'EOF' > iron-gallery-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: iron-gallery-deployment-datacenter
  namespace: iron-namespace-datacenter
spec:
  replicas: 1
  selector:
    matchLabels:
      run: iron-gallery
  template:
    metadata:
      labels:
        run: iron-gallery
    spec:
      containers:
        - name: iron-gallery-container-datacenter
          image: kodekloud/irongallery:2.0
          resources:
            limits:
              memory: "100Mi"
              cpu: "50m"
          volumeMounts:
            - name: config
              mountPath: /usr/share/nginx/html/data
            - name: images
              mountPath: /usr/share/nginx/html/uploads
      volumes:
        - name: config
          emptyDir: {}
        - name: images
          emptyDir: {}
EOF

# 3) Create the iron db deployment manifest
cat <<'EOF' > iron-db-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: iron-db-deployment-datacenter
  namespace: iron-namespace-datacenter
spec:
  replicas: 1
  selector:
    matchLabels:
      db: mariadb
  template:
    metadata:
      labels:
        db: mariadb
    spec:
      containers:
        - name: iron-db-container-datacenter
          image: kodekloud/irondb:2.0
          env:
            - name: MYSQL_DATABASE
              value: database_host
            - name: MYSQL_ROOT_PASSWORD
              value: "Str0ngRootP@ssw0rd!"
            - name: MYSQL_PASSWORD
              value: "C0mpl3xUserP@ssw0rd!"
            - name: MYSQL_USER
              value: "ironuser"
          volumeMounts:
            - name: db
              mountPath: /var/lib/mysql
      volumes:
        - name: db
          emptyDir: {}
EOF

# 4) Create the iron db service manifest
cat <<'EOF' > iron-db-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: iron-db-service-datacenter
  namespace: iron-namespace-datacenter
spec:
  selector:
    db: mariadb
  ports:
    - protocol: TCP
      port: 3306
      targetPort: 3306
  type: ClusterIP
EOF

# 5) Create the iron gallery service manifest
cat <<'EOF' > iron-gallery-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: iron-gallery-service-datacenter
  namespace: iron-namespace-datacenter
spec:
  selector:
    run: iron-gallery
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 32678
  type: NodePort
EOF

# 6) Apply all manifests
kubectl apply -f iron-gallery-deployment.yaml
kubectl apply -f iron-db-deployment.yaml
kubectl apply -f iron-db-service.yaml
kubectl apply -f iron-gallery-service.yaml

# 7) Verify resources
kubectl get all -n iron-namespace-datacenter
```

