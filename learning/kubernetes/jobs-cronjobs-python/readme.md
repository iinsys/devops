### Commands to use
```bash
eval $(minikube docker-env)

## build image
docker build . -t simplejob
## test image run locally
docker run -t --rm simplejob:latest

##create yaml file 
kubectl create cronjob simplejob --image=simplejob --schedule="*/5 * * * *" --dry-run=client -o yaml > job.yaml

##apply commands 
kubectl apply -f job.yaml
kubectl get cronjobs
kubectl get pods --watch
```