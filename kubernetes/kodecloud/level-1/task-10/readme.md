The Nautilus DevOps team needs a time check pod created in a specific Kubernetes namespace for logging purposes. Initially, it's for testing, but it may be integrated into an existing cluster later. Here's what's required:


Create a pod called time-check in the devops namespace. The pod should contain a container named time-check, utilizing the busybox image with the latest tag (specify as busybox:latest).

Create a config map named time-config with the data TIME_FREQ=8 in the same namespace.

Configure the time-check container to execute the command: while true; do date; sleep $TIME_FREQ;done. Ensure the result is written /opt/data/time/time-check.log. Also, add an environmental variable TIME_FREQ in the container, fetching its value from the config map TIME_FREQ key.

Create a volume log-volume and mount it at /opt/data/time within the container.

Note: The kubectl utility on jump_host is configured to operate with the Kubernetes cluster.

### Solution
```bash
kubectl create namespace devops
kubectl apply -f time-config.yaml
kubectl apply -f time-check-pod.yaml
kubectl get namespace
##Verify configmap
kubectl get configmap -n devops
kubectl describe configmap time-config -n devops
###check pod status
kubectl get pods -n devops
kubectl describe pod time-check -n devops
## Test to verify that log file is written
kubectl exec -n devops time-check -- cat /opt/data/time/time-check.log

```


