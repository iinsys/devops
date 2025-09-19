Day 64: Fix Python App Deployed on Kubernetes Cluster

>Whatever we believe about ourselves and our ability comes true for us.
>
>– Susan L. Taylor

One of the DevOps engineers was trying to deploy a python app on Kubernetes cluster. Unfortunately, due to some mis-configuration, the application is not coming up. Please take a look into it and fix the issues. Application should be accessible on the specified nodePort.

**1.** The deployment name is `python-deployment-datacenter`, its using `poroko/flask-demo-appimage`. The deployment and service of this app is already deployed.

**2.** `nodePort` should be `32345` and `targetPort` should be python flask app's default port.

> **Note:** The `kubectl` on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# Get the pods and descript to see the issue 
k get pods
k describe pod <pod-name>

# Patch the deployment with the correct image
kubectl set image deployment/python-deployment-datacenter \
  python-container-datacenter=poroko/flask-demo-app

# Verification Steps

# 1. Check deployment rollout
kubectl rollout status deployment/python-deployment-datacenter

# 2. Get pods to confirm running
kubectl get pods -l app=python_app -o wide

# 3. Describe service to confirm NodePort (should be 32345 → port 8080 → targetPort 5000)
kubectl describe svc python-service-datacenter

# 4. Test access inside cluster
POD=$(kubectl get pods -l app=python_app -o jsonpath='{.items[0].metadata.name}')
kubectl exec -it $POD -- curl http://localhost:5000

# 5. Test externally (from jumphost)
curl http://<NODE_IP>:32345

```