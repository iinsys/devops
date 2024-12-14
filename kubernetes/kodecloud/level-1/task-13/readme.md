The Nautilus DevOps team is establishing a ReplicationController to deploy multiple pods for hosting applications that require a highly available infrastructure. Follow the specifications below to create the ReplicationController:

1. Create a ReplicationController using the httpd image, preferably with latest tag, and name it httpd-replicationcontroller.

2. Assign labels app as httpd_app, and type as front-end. Ensure the container is named httpd-container and set the replica count to 3.

All pods should be running state post-deployment.

Note: The kubectl utility on jump_host is configured to operate with the Kubernetes cluster.

### Solution
```bash
kubectl apply -f httpd-replicationcontroller.yaml
kubectl get rc
kubectl get pods -l app=httpd_app,type=front-end
```