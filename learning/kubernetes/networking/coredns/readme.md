# CoreDNS in Kubernetes: Networking & Troubleshooting

CoreDNS is the default DNS server in Kubernetes, providing service discovery so pods and services can communicate using DNS names instead of IP addresses.

- Official docs: [Kubernetes DNS for Services and Pods](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/)
- CoreDNS project: [https://coredns.io/](https://coredns.io/)

---

# Demo: Pod-to-Pod Communication & CoreDNS Investigation

## 1. Deploy Two Nginx Pods and Expose with Services
You can create the resources using either `kubectl` commands or YAML manifest files.

### Option A: Using kubectl commands
```bash
kubectl create deployment nginx --image=nginx
kubectl create deployment nginx1 --image=nginx
kubectl expose deployment nginx --port=80 --target-port=80 --name=nginx
kubectl expose deployment nginx1 --port=80 --target-port=80 --name=nginx1
```

### Quick Test Commands
After the pods and services are running, you can quickly test connectivity:

- Test DNS-based communication:
  ```bash
  kubectl exec -it nginx -- curl nginx1
  ```
- Test direct IP communication (replace `<ip address svc1>` with the actual service IP):
  ```bash
  kubectl exec -it nginx -- curl <ip address svc1>
  ```

### Option B: Using YAML manifest files
_Apply with `kubectl apply -f <filename>.yaml`_

**nginx-deployment.yaml**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
```

**nginx-service.yaml**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
```

**nginx1-deployment.yaml**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx1
  template:
    metadata:
      labels:
        app: nginx1
    spec:
      containers:
      - name: nginx
        image: nginx
```

**nginx1-service.yaml**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx1
spec:
  selector:
    app: nginx1
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
```

---

## 2. Verify Pod and Service Status
Check that both pods and services are running and get their details (including IPs).
```bash
kubectl get pods -o wide
kubectl get svc
```

## 3. Test DNS-Based Communication
Try to access nginx1 from the nginx pod using the service name (DNS) and service IP. This demonstrates how CoreDNS enables service discovery.
```bash
kubectl exec -it <nginx-pod-name> -- curl nginx1 # via DNS
kubectl exec -it <nginx-pod-name> -- curl <nginx1-service-ip> # via IP
```

## 4. Investigate CoreDNS Deployment and Service
If DNS resolution fails, check the CoreDNS deployment and service in the kube-system namespace. You can also scale CoreDNS for redundancy.
```bash
kubectl get deploy -n kube-system
kubectl scale deploy coredns --replicas=2 -n kube-system
kubectl get deploy -n kube-system # verify scaling
kubectl get svc -n kube-system # kube-dns service (port 53)
```

## 5. Debug DNS Inside a Pod
Check the pod's DNS configuration and hosts file to understand how DNS is set up inside the container.
```bash
kubectl exec -it <nginx-pod-name> -- bash
cat /etc/resolv.conf
cat /etc/hosts
exit
```

## 6. Advanced CoreDNS Troubleshooting
Describe the CoreDNS deployment and inspect the CoreDNS ConfigMap (Corefile) for errors, health checks, and configuration.
```bash
kubectl describe deploy coredns -n kube-system
kubectl get cm -n kube-system
kubectl describe cm coredns -n kube-system # shows Corefile and settings
```

## 7. General Cluster/Network Checks
List all pods across namespaces and check for network plugins (e.g., Calico) if you suspect network issues.
```bash
kubectl get pods -A
# calico (if using Calico networking)
```

## 8. Autoscaling CoreDNS (DNS Autoscaler / HPA)
CoreDNS can be automatically scaled using a Horizontal Pod Autoscaler (HPA) based on CPU or memory usage. Some managed Kubernetes clusters deploy a DNS autoscaler by default. You can also create your own HPA for CoreDNS.

### Check for an existing DNS autoscaler
```bash
kubectl get deploy -n kube-system | grep dns
kubectl get hpa -n kube-system
```

### Example: Create an HPA for CoreDNS
This HPA will scale CoreDNS pods between 2 and 5 based on average CPU usage (target 70%).

**coredns-hpa.yaml**
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: coredns-hpa
  namespace: kube-system
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: coredns
  minReplicas: 2
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
```
_Apply with:_
```bash
kubectl apply -f coredns-hpa.yaml
kubectl get hpa -n kube-system
```

> **Note:** Your cluster must have the metrics server installed for HPA to work. See: https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/

---

> **Tip:** Replace `<nginx-pod-name>` and `<nginx1-service-ip>` with actual values from your cluster. Use `kubectl get pods` and `kubectl get svc` to find them.

---

This structure provides a clear, step-by-step workflow for testing and troubleshooting CoreDNS and pod networking in Kubernetes.

