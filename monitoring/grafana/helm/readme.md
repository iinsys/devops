## Commands to use
```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

## install grafana
helm install grafana grafana/grafana --namespace my-grafana --create-namespace

##Get the password
kubectl get secret --namespace my-grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

## Access grafana on local machine
kubectl port-forward --namespace my-grafana svc/grafana 3000:80
```

## using custom-helm chart
```bash
helm package custom-helm

helm install grafana ./custom-helm --namespace my-grafana --create-namespace

## Verify deployment
##pvc
kubectl get pvc --namespace=my-grafana -o wide

## deployment
kubectl get deployments --namespace=my-grafana -o wide

# service
kubectl get svc --namespace=my-grafana -o wide

# ingress
kubectl get ingress --namespace=my-grafana -o wide

minikube addons enable ingress

## update /etc/hosts
sudo nano /etc/hosts

MINIKUBE_IP grafana.local
```
(Access Grafana in browser)(http://grafana.local)
