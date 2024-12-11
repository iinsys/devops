### DaemonSet Use Cases
- Log Collection and Monitoring(fluentd, logstash, Monitoring(data dog or prometheus))
- Network Proxies(Cilium, weavenet)
- Resource Monitoriing
- System-Level Services
---
- It makes sure that a pod runs on each node always

```bash
kubectl api-resources | grep daemonset

kubectl apply -f daemonset.yaml
## get ds
kubectl get ds
## get pods created by daemonset
kubectl get pods
## get nodes running on minikube cluste which is one
kubectl get nodes

## Add one node to the cluster
minikube node add 
kubectl get nodes

## New pod should be created on the newly added node
kubectl get pods -o wide ## to see all pods running on all nodoes
## Delete node to see if pod will be taken away from that node
kubectl delete node <node name>

## Verify node deletion
kubectl get nodes
## get pods to see that pods has been stopped
kubectl get pods

## port forward to see monitoring
kubectl port-forward <pod-name> 9100:9100

#access on the browser
localhost:9100/metrics

## Check kube-proxy daemonset running in the kube-system
kubectl get ds -A
kubectl get pods -n kube-system

## delete daemon set
kubectl delete ds node-exporter
## verify
kubectl get pods

## Delete daemon set without deleting pods ran by daemonset
kubectl delete ds node-exporter --cascade=false
```