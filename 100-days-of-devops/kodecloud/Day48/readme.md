Day 48: Deploy Pods in Kubernetes Cluster

>I hear and I forget. I see and I remember. I do and I understand.
>
>– Confucius

The Nautilus DevOps team is diving into Kubernetes for application management. One team member has a task to create a pod according to the details below:


Create a pod named `pod-httpd` using the `httpd` image with the `latest` tag. Ensure to specify the tag as httpd:latest.

1. Set the app label to `httpd_app`, and name the container as `httpd-container`.

`Note:` The `kubectl` utility on `jump_host` is configured to operate with the Kubernetes cluster.

## Solution
```bash
# ===============================
# Imperative Commands
# ===============================

# 1. Create the pod directly with imperative command
kubectl run pod-httpd \
  --image=httpd:latest \
  --restart=Never \
  --labels="app=httpd_app" \
  --port=80 \
  --overrides='
{
  "apiVersion": "v1",
  "spec": {
    "containers": [
      {
        "name": "httpd-container",
        "image": "httpd:latest"
      }
    ]
  }
}'

# Verify pod creation
kubectl get pods -o wide
kubectl describe pod pod-httpd


# ===============================
# Declarative (YAML) Method
# ===============================

# 2. Create YAML file for the pod
cat <<EOF > pod-httpd.yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-httpd
  labels:
    app: httpd_app
spec:
  containers:
    - name: httpd-container
      image: httpd:latest
      ports:
        - containerPort: 80
EOF

# Apply the YAML file
kubectl apply -f pod-httpd.yaml

# Verify
kubectl get pods -l app=httpd_app
kubectl describe pod pod-httpd
```



