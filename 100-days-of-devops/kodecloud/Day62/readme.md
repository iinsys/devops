Day 62: Manage Secrets in Kubernetes

>You are never too old to set another goal or to dream a new dream.
>
>– Malala Yousafzai

The Nautilus DevOps team is working to deploy some tools in Kubernetes cluster. Some of the tools are licence based so that licence information needs to be stored securely within Kubernetes cluster. Therefore, the team wants to utilize Kubernetes secrets to store those secrets. Below you can find more details about the requirements:

**1.** We already have a secret key file `blog.txt` under `/opt` location on jump host. Create a generic secret named `blog`, it should contain the password/license-number present in `blog.txt` file.

**2.** Also create a pod named `secret-datacenter`.

**3.** Configure pod's spec as container name should be `secret-container-datacenter`, image should be `debian` with `latest` tag (remember to mention the tag with image). Use `sleep` command for container so that it remains in running state. Consume the created secret and mount it under `/opt/apps` within the container.

**4.** To verify you can exec into the container `secret-container-datacenter`, to check the secret key under the mounted path `/opt/apps`. Before hitting the Check button please make sure pod/pods are in running state, also validation can take some time to complete so keep patience.

> **Note:** The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# 1) Create the secret from the file
kubectl create secret generic blog --from-file=blog.txt=/opt/blog.txt

# 2) Create the pod manifest that mounts the secret
cat <<'EOF' > day62-secret-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-datacenter
spec:
  containers:
    - name: secret-container-datacenter
      image: debian:latest
      command: ["sleep", "3600"]
      volumeMounts:
        - name: blog-secret
          mountPath: /opt/apps
  volumes:
    - name: blog-secret
      secret:
        secretName: blog
EOF

# 3) Apply the manifest
kubectl apply -f day62-secret-pod.yaml

# 4) Verify the pod and secret
kubectl get pod secret-datacenter
kubectl get secret blog

# 5) Verification: Exec into the container to check the secret
kubectl exec -it secret-datacenter -- ls /opt/apps
kubectl exec -it secret-datacenter -- cat /opt/apps/blog.txt
```

