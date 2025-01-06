### Command to use
```bash
##validate availibility zones
aws ec2 describe-availability-zones --region <region>

alias tf=terraform
tf init
tf plan
tf apply --auto-approve

## connect to cluster
aws eks update-kubeconfig --region=eu-central-1 --name=devops-nb-cluster

## get default pods might have permission error if iam does not have sufficient permissions
kubectl get pods
kubectl get nodes
## get cluster info
kubectl cluster-info


tf destroy --auto-approve
```
