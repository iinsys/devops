Day 67: Deploy Guest Book App on Kubernetes

>Real difficulties can be overcome; it is only the imaginary ones that are unconquerable.
>
>– Theodore N. Vail

The Nautilus Application development team has finished development of one of the applications and it is ready for deployment. It is a guestbook application that will be used to manage entries for guests/visitors. As per discussion with the DevOps team, they have finalized the infrastructure that will be deployed on Kubernetes cluster. Below you can find more details about it.

**BACK-END TIER**

Create a deployment named `redis-master` for Redis master.

a.) Replicas count should be `1`.

b.) Container name should be `master-redis-devops` and it should use image `redis`.

c.) Request resources as CPU should be `100m` and Memory should be `100Mi`.

d.) Container port should be redis default port i.e `6379`.

Create a service named `redis-master` for Redis master. Port and targetPort should be Redis default port i.e `6379`.

Create another deployment named `redis-slave` for Redis slave.

a.) Replicas count should be `2`.

b.) Container name should be `slave-redis-devops` and it should use `gcr.io/google_samples/gb-redisslave:v3` image.

c.) Requests resources as CPU should be `100m` and Memory should be `100Mi`.

d.) Define an environment variable named `GET_HOSTS_FROM` and its value should be `dns`.

e.) Container port should be Redis default port i.e `6379`.

Create another service named `redis-slave`. It should use Redis default port i.e `6379`.

**FRONT END TIER**

Create a deployment named `frontend`.

a.) Replicas count should be `3`.

b.) Container name should be `php-redis-devops` and it should use `gcr.io/google-samples/gb-frontend@sha256:a908df8486ff66f2c4daa0d3d8a2fa09846a1fc8efd65649c0109695c7c5cbff` image.

c.) Request resources as CPU should be `100m` and Memory should be `100Mi`.

d.) Define an environment variable named as `GET_HOSTS_FROM` and its value should be `dns`.

e.) Container port should be `80`.

Create a service named `frontend`. Its type should be `NodePort`, port should be `80` and its nodePort should be `30009`.

Finally, you can check the guestbook app by clicking on App button.

You can use any labels as per your choice.

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
cat <<EOF > guestbook-app.yaml
---
# Redis Master Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-master
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis-master
  template:
    metadata:
      labels:
        app: redis-master
    spec:
      containers:
        - name: master-redis-devops
          image: redis
          ports:
            - containerPort: 6379
          resources:
            requests:
              cpu: "100m"
              memory: "100Mi"
---
# Redis Master Service
apiVersion: v1
kind: Service
metadata:
  name: redis-master
spec:
  selector:
    app: redis-master
  ports:
    - port: 6379
      targetPort: 6379
---
# Redis Slave Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-slave
spec:
  replicas: 2
  selector:
    matchLabels:
      app: redis-slave
  template:
    metadata:
      labels:
        app: redis-slave
    spec:
      containers:
        - name: slave-redis-devops
          image: gcr.io/google_samples/gb-redisslave:v3
          ports:
            - containerPort: 6379
          resources:
            requests:
              cpu: "100m"
              memory: "100Mi"
          env:
            - name: GET_HOSTS_FROM
              value: "dns"
---
# Redis Slave Service
apiVersion: v1
kind: Service
metadata:
  name: redis-slave
spec:
  selector:
    app: redis-slave
  ports:
    - port: 6379
      targetPort: 6379
---
# Frontend Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
        - name: php-redis-devops
          image: gcr.io/google-samples/gb-frontend@sha256:a908df8486ff66f2c4daa0d3d8a2fa09846a1fc8efd65649c0109695c7c5cbff
          ports:
            - containerPort: 80
          resources:
            requests:
              cpu: "100m"
              memory: "100Mi"
          env:
            - name: GET_HOSTS_FROM
              value: "dns"
---
# Frontend Service
apiVersion: v1
kind: Service
metadata:
  name: frontend
spec:
  type: NodePort
  selector:
    app: frontend
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30009
EOF

# Apply
kubectl apply -f guestbook-app.yaml

# Verify deployments and pods
kubectl get deployments
kubectl get pods -o wide

# Verify services
kubectl get svc

# Describe frontend service to confirm NodePort 30009
kubectl describe svc frontend

# Test frontend app from jumphost
curl http://<NODE_IP>:30009
#or click the App button
```

