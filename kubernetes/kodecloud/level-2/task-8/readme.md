A new java-based application is ready to be deployed on a Kubernetes cluster. The development team had a meeting with the DevOps team to share the requirements and application scope. The team is ready to setup an application stack for it under their existing cluster. Below you can find the details for this:


1. Create a namespace named `tomcat-namespace-datacenter`.

2. Create a deployment for tomcat app which should be named as `tomcat-deployment-datacenter` under the same namespace you created. Replica count should be 1, the container should be named as t`omcat-container-datacenter`, its image should be `gcr.io/kodekloud/centos-ssh-enabled:tomcat` and its container port should be `8080`.

3. Create a `service` for tomcat app which should be named as `tomcat-service-datacenter` under the same namespace you created. Service type should be `NodePort` and nodePort should be `32227`.


Before clicking on `Check` button please make sure the application is up and running.


`You can use any labels as per your choice.`


`Note`: The `kubectl` on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
## apply files
kubectl apply -f tomcat-namespace.yaml
kubectl apply -f tomcat-deployment.yaml
kubectl apply -f tomcat-service.yaml

## verify
# List namespaces
kubectl get namespaces

# Verify the deployment
kubectl get deployments -n tomcat-namespace-datacenter

# Verify the pods
kubectl get pods -n tomcat-namespace-datacenter

# Verify the service
kubectl get svc -n tomcat-namespace-datacenter

## Access application
click the cookie icon where we have App
or if there is not you can do this 
kubectl get nodes -o wide

```