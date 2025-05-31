# Using Nginx Ingress Controller, Cert-Manager, and ngrok on Minikube for HTTPS with Let’s Encrypt 🚀

Serve your web apps over **HTTPS** locally using **Nginx Ingress**, **Cert-Manager**, and **ngrok**. This setup allows Let’s Encrypt to issue TLS certificates even when your cluster is local (Minikube).

---

## 🔧 Prerequisites

- Minikube installed and started
- `kubectl` installed and configured
- `helm` installed
- An [ngrok](https://ngrok.com/) account + installed CLI

---

## 1️⃣ Start Minikube

```bash
minikube start
```

---

## 2️⃣ Install Nginx Ingress Controller

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx --create-namespace
```

Check:

```bash
kubectl get svc -n ingress-nginx
```

You should see a `LoadBalancer` IP like `192.168.49.2`.

---

## 3️⃣ Install Cert-Manager

```bash
helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager --create-namespace \
  --version v1.14.1 \
  --set installCRDs=true
```

Verify all pods:

```bash
kubectl get pods -n cert-manager
```

---

## 4️⃣ Start ngrok to Expose Minikube

```bash
ngrok http <minikube ip>:80
```

Copy the forwarded domain (e.g., `https://your-xyz.ngrok.io`). You will use it as your **Ingress host**.

---

## 5️⃣ Apply ClusterIssuer Configuration

```bash
kubectl apply -f letsencrypt-staging.yaml
```

---

## 6️⃣ Deploy Applications

- Apply the `hello-app.yaml` file:
  ```bash
  kubectl apply -f hello-app.yaml
  ```
- Apply the `welcome-app.yaml` file:
  ```bash
  kubectl apply -f welcome-app.yaml
  ```

---

## 7️⃣ Set Up Ingress

- Apply the ingress configuration with the ngrok URL:
  ```bash
  kubectl apply -f greeting-ingress-ngrok.yaml
  ```
- Apply the ingress configuration without the ngrok URL:
  ```bash
  kubectl apply -f greeting-ingress.yaml
  ```

---

## Debugging Steps

1. **Check Pod Status**
   ```bash
   kubectl get pods
   ```
   Ensure all pods are running without errors.

2. **Check Service Status**
   ```bash
   kubectl get services
   ```
   Verify that the services are correctly exposed.

3. **Check Ingress Status**
   ```bash
   kubectl get ingress
   ```
   Confirm that the ingress rules are applied and the host URLs are accessible.

4. **Inspect Logs**
   - For pods:
     ```bash
     kubectl logs <pod-name>
     ```
   - For ingress controller:
     ```bash
     kubectl logs -n ingress-nginx <controller-pod-name>
     ```

5. **Test Connectivity**
   Use `curl` or a browser to test the URLs defined in the ingress configurations.

6. **Verify Certificates**
   Check if TLS certificates are correctly issued:
   ```bash
   kubectl describe certificate
   ```
