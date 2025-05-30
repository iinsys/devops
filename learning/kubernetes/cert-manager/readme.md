# Using Nginx Ingress Controller, Cert-Manager, and ngrok on Minikube for HTTPS with Let’s Encrypt 🚀

Serve your web apps over **HTTPS** locally using **Nginx Ingress**, **Cert-Manager**, and **ngrok**. This setup allows Let’s Encrypt to issue TLS certificates even when your cluster is local (Minikube).

---

## 🔧 Prerequisites

- Minikube installed and started
- `kubectl` installed and configured
- `helm` installed
- An [ngrok](https://ngrok.com/) account + installed CLI
- A **public domain or use ngrok’s temporary one** (for HTTPS validation)

---

## 1️⃣ Start Minikube and Enable Tunnel

```bash
minikube start
minikube tunnel
```

Leave the `minikube tunnel` running in a separate terminal. It enables LoadBalancer services to work.

---

## 2️⃣ Install Nginx Ingress Controller

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx --create-namespace
```
Incase you encounter error 
```bash
# Delete the existing namespace and everything in it
kubectl delete namespace ingress-nginx

# Wait until the namespace is fully deleted
kubectl get ns

# Reinstall using Helm
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
ngrok http 80
```

Copy the forwarded domain (e.g., `https://your-xyz.ngrok.io`). You will use it as your **Ingress host**.

---

## 5️⃣ Create ClusterIssuer for Let’s Encrypt (Staging for testing)

**`letsencrypt-staging.yaml`**

```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
spec:
  acme:
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    email: youremail@example.com
    privateKeySecretRef:
      name: letsencrypt-staging-account-key
    solvers:
      - http01:
          ingress:
            class: nginx
```

```bash
kubectl apply -f letsencrypt-staging.yaml
```

---

## 6️⃣ Deploy Example App

```bash
kubectl create namespace demo
kubectl create deployment hello-world --image=nginx -n demo
kubectl expose deployment hello-world --port=80 --type=ClusterIP -n demo
```

---

## 7️⃣ Create Ingress Resource Using ngrok Host

Replace `your-xyz.ngrok.io` with your **actual ngrok URL**.

**`hello-world-ingress.yaml`**

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-world-ingress
  namespace: demo
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-staging"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - your-xyz.ngrok.io
      secretName: hello-world-tls
  rules:
    - host: your-xyz.ngrok.io
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: hello-world
                port:
                  number: 80
```

Apply:

```bash
kubectl apply -f hello-world-ingress.yaml
```

---

## 8️⃣ Verify Certificate Issuance

```bash
kubectl describe ingress hello-world-ingress -n demo
kubectl get certificate -n demo
kubectl logs -n cert-manager deploy/cert-manager
```

### Debuging 
```bash
kubectl describe certificate hello-world-tls -n demo
kubectl get challenge -n demo
kubectl describe challenge <challenge-name> -n demo
kubectl logs -n cert-manager deploy/cert-manager
```

Visit:

```text
https://your-xyz.ngrok.io
```

You should see the Nginx welcome page — served over **HTTPS** with a valid (staging) Let’s Encrypt certificate.

---

## ✅ Final Notes

- **Let’s Encrypt staging** is for testing — use `letsencrypt-production.yaml` only after confirming it works.
- For **custom domains**, you can CNAME to the ngrok domain or use DNS-01 challenges instead.

---

## 🔁 Automatic Renewal

Cert-Manager handles renewals automatically. Once set up, certificates will renew before expiration.

---

## 🛠 Troubleshooting

```bash
kubectl describe certificate hello-world-tls -n demo
kubectl describe challenge -n demo
kubectl logs -n cert-manager deploy/cert-manager
```

✅ That’s it! You now have HTTPS for your local Minikube app using Let’s Encrypt and ngrok! 🚀
