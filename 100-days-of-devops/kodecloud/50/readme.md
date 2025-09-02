Day 50: Set Resource Limits in Kubernetes Pods

>Be not in despair, the way is very difficult, like walking on the edge of a razor; yet despair not, arise, awake, and find the ideal, the goal.
>
>– Swami Vivekananda

The Nautilus DevOps team has noticed performance issues in some Kubernetes-hosted applications due to resource constraints. To address this, they plan to set limits on resource utilization. Here are the details:


Create a pod named httpd-pod with a container named `httpd-container`. Use the `httpd` image with the latest tag (specify as `httpd:latest`). Set the following resource limits:

Requests: Memory: `15Mi`, CPU: 100m

Limits: Memory: `20Mi`, CPU: `100m`

Note: The `kubectl` utility on `jump_host` is configured to operate with the Kubernetes cluster.

## Solution
```bash
# --- Imperative Command (with dry-run to YAML) ---
kubectl run httpd-pod \
  --image=httpd:latest \
  --restart=Never \
  --dry-run=client -o yaml > httpd-pod.yaml

# Edit the YAML to add container name and resource limits
cat <<EOF > httpd-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: httpd-pod
  labels:
    app: httpd_app
spec:
  containers:
  - name: httpd-container
    image: httpd:latest
    resources:
      requests:
        memory: "15Mi"
        cpu: "100m"
      limits:
        memory: "20Mi"
        cpu: "100m"
EOF

# Apply the Pod manifest
kubectl apply -f httpd-pod.yaml

# Verify pod creation and resource limits
kubectl get pod httpd-pod -o wide
kubectl describe pod httpd-pod | grep -A5 "Limits"

```