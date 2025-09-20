Day 58: Deploy Grafana on Kubernetes Cluster

>The things always happens that you really believe in; and the belief in a thing makes it happen.
>
>– Frank Lloyd Wright

The Nautilus DevOps teams is planning to set up a Grafana tool to collect and analyze analytics from some applications. They are planning to deploy it on Kubernetes cluster. Below you can find more details.



1.) Create a deployment named `grafana-deployment-nautilus` using any grafana image for Grafana app. Set other parameters as per your choice.


2.) Create `NodePort` type service with nodePort `32000` to expose the app.


>You need not to make any configuration changes inside the Grafana app once deployed, just make sure you are able to access the Grafana login page.


`Note:` The `kubectl` on `jump_host` has been configured to work with kubernetes cluster.

## Solution
```bash
# 1) Create the deployment manifest
cat <<'EOF' > grafana-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana-deployment-nautilus
spec:
  replicas: 1
  selector:
    matchLabels:
      app: grafana
  template:
    metadata:
      labels:
        app: grafana
    spec:
      containers:
        - name: grafana-container
          image: grafana/grafana:latest
          ports:
            - containerPort: 3000
EOF

# 2) Create the service manifest
cat <<'EOF' > grafana-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: grafana-service
spec:
  type: NodePort
  selector:
    app: grafana
  ports:
    - port: 3000
      targetPort: 3000
      nodePort: 32000
EOF

# 3) Apply the manifests
kubectl apply -f grafana-deployment.yaml
kubectl apply -f grafana-service.yaml

# 4) Verify deployment and service
kubectl get deployments grafana-deployment-nautilus
kubectl get pods -l app=grafana
kubectl get svc grafana-service

# 5) Access Grafana in browser using:
# Click Grafana app button

```




