# Testing the bjw-s-app Helm Chart

This guide explains how to test the `bjws-app` Helm chart using the bjw-s common library, including verifying deployment, service, and ingress.

## Prerequisites
- Helm installed (`helm version`)
- Kubernetes cluster running (e.g., Minikube, Kind, or any K8s cluster)
- (Optional) NGINX Ingress Controller installed if you want to test ingress

---

## 1. Add the bjw-s-labs Helm Repository
```sh
helm repo add bjw-s-labs https://bjw-s-labs.github.io/helm-charts/
helm repo update
```

## 2. Install Chart Dependencies
```sh
cd bjws-app

# Fetch and build chart dependencies (required for bjw-s common library)
helm dependency build .
```

## 3. Install the Chart
```sh
# If you are inside the bjws-app directory:
helm install bjws-app . -n default --create-namespace

# If you are in the parent directory:
# helm install bjw-s-app bjw-s-app -n default --create-namespace
```

## 4. Verify the Deployment
```sh
kubectl get pods -l app.kubernetes.io/name=bjws-app
kubectl get svc -l app.kubernetes.io/name=bjws-app
kubectl get ingress -l app.kubernetes.io/name=bjws-app
```

## 5. Test Ingress (if enabled)
- Get your Minikube IP (if using Minikube):
```sh
  minikube ip
```
- Add a hosts entry on your machine:
```sh
  echo "$(minikube ip) bjws-app.local" | sudo tee -a /etc/hosts
```
- Test access in your browser or with curl:
  curl http://bjws-app.local/


## 6. Uninstall the Chart
```sh
helm uninstall bjws-app
```

---

## Notes
- You can customize values by editing `values.yaml` or using `--set` flags.
- For more advanced tests and usage, see the bjw-s common library documentation: https://github.com/bjw-s-labs/helm-charts/blob/main/charts/library/common/README.md

---

Happy Helm testing!
