Day 65: Deploy Redis Deployment on Kubernetes

>If you really look closely, most overnight successes took a long time.
>
>– Steve Jobs

The Nautilus application development team observed some performance issues with one of the application that is deployed in Kubernetes cluster. After looking into number of factors, the team has suggested to use some in-memory caching utility for DB service. After number of discussions, they have decided to use Redis. Initially they would like to deploy Redis on kubernetes cluster for testing and later they will move it to production. Please find below more details about the task:


### Create a redis deployment with following parameters:

1. Create a `config map` called `my-redis-config` having maxmemory `2mb` in `redis-config`.

2. Name of the deployment should be `redis-deployment`, it should use
`redis:alpine` image and container name should be `redis-container`. Also make sure it has only `1 replica`.

3. The container should request for `1 CPU`.

4. `Mount 2 volumes`:

    a. An `Empty` directory volume called `data` at path `/redis-master-data`.

    b. A `configmap volume` called `redis-config` at path `/redis-master`.

    c. The container should expose the port `6379`.

5. Finally, `redis-deployment` should be in an up and running state.

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# Create ConfigMap + Deployment 
cat <<'EOF' > redis-deploy.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-redis-config
data:
  redis-config: |-
    maxmemory 2mb
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
        - name: redis-container
          image: redis:alpine
          ports:
            - containerPort: 6379
          resources:
            requests:
              cpu: "1"
          volumeMounts:
            - name: data
              mountPath: /redis-master-data
            - name: redis-config
              mountPath: /redis-master
      volumes:
        - name: data
          emptyDir: {}
        - name: redis-config
          configMap:
            name: my-redis-config
EOF

# Apply manifest
kubectl apply -f redis-deploy.yaml

# Verification 
kubectl rollout status deployment/redis-deployment

kubectl get deployment redis-deployment

kubectl get pods -l app=redis -o wide

kubectl describe deployment redis-deployment

# show the deployed pod name 
kubectl get pods -l app=redis -o jsonpath='{.items[0].metadata.name}' -n default


```




