The Nautilus DevOps team is gearing up to deploy applications on a Kubernetes cluster for migration purposes. A team member has been tasked with creating a ReplicaSet outlined below:


Create a ReplicaSet using nginx image with latest tag (ensure to specify as nginx:latest) and name it nginx-replicaset.


Apply labels: app as nginx_app, type as front-end.


Name the container nginx-container. Ensure the replica count is 4.


Note: The kubectl utility on jump_host is set up to interact with the Kubernetes cluster.

## Solution
```bash
kubectl apply -f nginx-replicaset.yaml

kubectl get replicaset
kubectl get pods -l app=nginx_app
kubectl describe replicaset nginx-replicaset
kubectl get events

```