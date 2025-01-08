### Commands to use

```bash
kubectl apply -f grafana-pvc.yaml
kubectl apply -f grafana-deployment.yaml
kubectl apply -f grafana-service.yaml
kubectl apply -f grafana-ingress.yaml
kubectl apply -f grafana-ns.yml

minikube addons enable ingress

sudo nano /etc/hosts

MINIKUBE_IP grafana.local

```

Open a web browser and navigate to http://grafana.local. You should see the Grafana login page.