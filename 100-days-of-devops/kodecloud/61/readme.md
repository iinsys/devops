Day 61: Init Containers in Kubernetes

>People who are really serious about software should make their own hardware.
>
>– Alan Kay

There are some applications that need to be deployed on Kubernetes cluster and these apps have some pre-requisites where some configurations need to be changed before deploying the app container. Some of these changes cannot be made inside the images so the DevOps team has come up with a solution to use init containers to perform these tasks during deployment. Below is a sample scenario that the team is going to test first.

**1.** Create a Deployment named as `ic-deploy-xfusion`.

**2.** Configure `spec` as replicas should be `1`, labels `app` should be `ic-xfusion`, template's metadata labels `app` should be the same `ic-xfusion`.

**3.** The `initContainers` should be named as `ic-msg-xfusion`, use image `fedora` with `latest` tag and use command `'/bin/bash', '-c'` and `'echo Init Done - Welcome to xFusionCorp Industries > /ic/official'`. The volume mount should be named as `ic-volume-xfusion` and mount path should be `/ic`.

**4.** Main container should be named as `ic-main-xfusion`, use image `fedora` with `latest` tag and use command `'/bin/bash', '-c'` and `'while true; do cat /ic/official; sleep 5; done'`. The volume mount should be named as `ic-volume-xfusion` and mount path should be `/ic`.

**5.** Volume to be named as `ic-volume-xfusion` and it should be an `emptyDir` type.

> **Note:** The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# 1) Create the deployment manifest with initContainer and main container
cat <<'EOF' > day61-ic-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ic-deploy-xfusion
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ic-xfusion
  template:
    metadata:
      labels:
        app: ic-xfusion
    spec:
      initContainers:
        - name: ic-msg-xfusion
          image: fedora:latest
          command: ["/bin/bash", "-c", "echo Init Done - Welcome to xFusionCorp Industries > /ic/official"]
          volumeMounts:
            - name: ic-volume-xfusion
              mountPath: /ic
      containers:
        - name: ic-main-xfusion
          image: fedora:latest
          command: ["/bin/bash", "-c", "while true; do cat /ic/official; sleep 5; done"]
          volumeMounts:
            - name: ic-volume-xfusion
              mountPath: /ic
      volumes:
        - name: ic-volume-xfusion
          emptyDir: {}
EOF

# 2) Apply the manifest
kubectl apply -f day61-ic-deployment.yaml

# 3) Verify the deployment and pod
kubectl get deployments ic-deploy-xfusion
kubectl get pods -l app=ic-xfusion

# 4) Check logs to confirm initContainer and main container behavior
kubectl logs -l app=ic-xfusion -c ic-main-xfusion

# OR use
POD=$(kubectl get pods -l app=ic-xfusion -o jsonpath='{.items[0].metadata.name}')
kubectl logs $POD -c ic-main-xfusion
```