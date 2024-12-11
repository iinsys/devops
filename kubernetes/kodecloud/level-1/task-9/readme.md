The Nautilus DevOps team is crafting jobs in the Kubernetes cluster. While they're developing actual scripts/commands, they're currently setting up templates and testing jobs with dummy commands. Please create a job template as per details given below:


Create a job named countdown-datacenter.

The spec template should be named countdown-datacenter (under metadata), and the container should be named container-countdown-datacenter

Utilize image debian with latest tag (ensure to specify as debian:latest), and set the restart policy to Never.

Execute the command sleep 5

Note: The kubectl utility on jump_host is set up to operate with the Kubernetes cluster.

### Solution
```bash
kubectl apply -f countdown-datacenter-job.yaml
##check job status
kubectl get jobs
##check job logs
kubectl logs <pod-name>

```