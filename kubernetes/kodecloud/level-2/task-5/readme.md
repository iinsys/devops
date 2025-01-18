There is a production deployment planned for next week. The Nautilus DevOps team wants to test the deployment update and rollback on Dev environment first so that they can identify the risks in advance. Below you can find more details about the plan they want to execute.



1. Create a namespace `devops`. Create a deployment called `httpd-deploy` under this new namespace, It should have one container called `httpd`, use `httpd:2.4.25` image and `3` replicas. The deployment should use ``RollingUpdate strategy with `maxSurge=1`, and `maxUnavailable=2`. Also create a `NodePort` type service named `httpd-service` and expose the deployment on nodePort: `30008`.


2. Now upgrade the deployment to version `httpd:2.4.43` using a rolling update.


3. Finally, once all pods are updated undo the recent update and roll back to the previous/original version.


`Note:`

a. The `kubectl` utility on jump_host has been configured to work with the kubernetes cluster.


b. Please make sure you only use the specified image(s) for this deployment and as per the sequence mentioned in the task description. If you mistakenly use a wrong image and fix it later, that will also distort the revision history which can eventually fail this task.

## Solution
```bash
## create namespace
kubectl create namespace devops

## apply file
kubectl apply -f httpd-deploy.yaml

## verify deployment and service
kubectl get deployments -n devops
kubectl get pods -n devops
kubectl get svc -n devops

## perform a rolling update: Update the deployment to use the httpd:2.4.43 image:
kubectl set image deployment/httpd-deploy httpd=httpd:2.4.43 -n devops

## monitor rollout
kubectl rollout status deployment/httpd-deploy -n devops

## verify the updated pod
kubectl get pods -n devops -o wide

## Undo the Recent Update,Rollback the deployment to the previous version:
kubectl rollout undo deployment/httpd-deploy -n devops

## verify rollback
kubectl rollout history deployment/httpd-deploy -n devops
kubectl get pods -n devops -o wide

## verify the svc having the port number 30008
kubectl get svcs -n devops
```


