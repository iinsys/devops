# 🚀 Day 10 – Build a Real Kubernetes App (and Get Your Handbook!)

Yes, we know — this final 10th lesson arrived a little late. But we didn’t want to just send another email — we wanted to send something **truly useful**.

### 🎁 Along with this hands-on lesson, you get:
👉 [Kubernetes Made Easy eBook](https://kodekloud.com/kubernetes-made-easy?utm_term=download_the_ebook_here&utm_campaign=email_course_kubernetes&utm_medium=email&_hsenc=p2ANqtz--sXaGJdybRMe-uT6xdbdJaUeVOrqCjG6zhyKY3UDzCeNqPRCXpSiv2YErPwBsWBcpNe0Ul-96C0tCnbA9ckJO5lXJB2arHEL9SFHDdO7qwjKb5WDo&_hsmi=364567349&utm_content=email10&utm_source=hubspot) — a complete, searchable handbook  
📘 Great as a refresher for real-world work or KCNA/CKA prep

---

## ✅ You’ve Made It Through!

You now understand:

- Pods  
- Deployments  
- Services  
- ConfigMaps  
- Secrets  
- Probes  
...and more!

Now, let’s bring them all together into a **real-world app** deployment.

---

## 🧱 What You’ll Deploy

- **Deployment** (2 NGINX Pods)  
- **ConfigMap** (stores config)  
- **Secret** (stores credentials)  
- **Liveness & Readiness Probes**  
- **NodePort Service** (exposes app externally)

---

## 🔧 Step-by-Step Setup

---

### 🔹 Step 1: ConfigMap

📄 `configmap.yaml`

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  APP_MODE: "production"
```

Stores `APP_MODE=production` as environment variable.

---

### 🔹 Step 2: Secret

📄 `secret.yaml`

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
type: Opaque
data:
  username: YWRtaW4=         # admin
  password: c2VjdXJlcGFzcw== # securepass
```

Securely injects sensitive info (base64-encoded).

---

### 🔹 Step 3: Deployment (with Probes)

📄 `deployment.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: nginx
          image: nginx:1.21
          ports:
            - containerPort: 80
          envFrom:
            - configMapRef:
                name: app-config
          env:
            - name: ADMIN_USER
              valueFrom:
                secretKeyRef:
                  name: app-secret
                  key: username
            - name: ADMIN_PASS
              valueFrom:
                secretKeyRef:
                  name: app-secret
                  key: password
          livenessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 10
            failureThreshold: 3
          readinessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 5
            failureThreshold: 2
```

---

### 🔹 Step 4: NodePort Service

📄 `service.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-service
spec:
  type: NodePort
  selector:
    app: web
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30080
```

📌 Access your app via:  
`http://<Node-IP>:30080`

---

## ⚙️ Quick Commands to Deploy It All

```bash
kubectl apply -f configmap.yaml         # Apply config
kubectl apply -f secret.yaml            # Apply secret
kubectl apply -f deployment.yaml        # Deploy the app
kubectl get pods -w                     # Watch pods come alive
kubectl describe pod <pod-name>        # Troubleshoot details
kubectl logs <pod-name>                # View app logs
kubectl apply -f service.yaml          # Expose the app
kubectl get service web-service        # Check NodePort info
kubectl port-forward service/web-service 8080:80  # Optional port-forward
kubectl exec -it <pod-name> -- env     # Check injected ENV vars
kubectl get pods                       # List all pods
```

---

## 🛠️ You Did It!

You've built a **real, scalable, configurable, and health-checked** Kubernetes app.

---

## 🗺️ What’s Next? Your Kubernetes Roadmap

### 🔹 PHASE 1: Master YAML
- Write manifests from scratch  
- Try different `Service` types  
- Mount ConfigMaps & Secrets as files  

### 🔹 PHASE 2: Learn Tools
- Helm, K9s, Lens  
- `kubectl exec`, `port-forward`, `logs`

### 🔹 PHASE 3: Cluster Resources
- Limits, affinity, taints, node selectors  
- Namespaces, network policies  

### 🔹 PHASE 4: Security
- RBAC, audit logging  
- Secrets best practices  
- Study for: KCNA, KCSA  

### 🔹 PHASE 5: Real Cluster Practice
- Use `minikube`, `kind`, or `Play with K8s`  
- Deploy to GKE, EKS, or AKS  

---

## 🔁 Want to Go Beyond?

| **If You Liked This…**         | **Try This…**                            |
|--------------------------------|------------------------------------------|
| YAML + Basics                  | [Helm](https://helm.sh/) or [Kustomize](https://kustomize.io/)          |
| Pods + Configs                 | StatefulSets + Persistent Volumes        |
| Services + Networking          | Ingress Controllers + CoreDNS            |
| Manual Deployments             | CI/CD with [ArgoCD](https://argo-cd.readthedocs.io/en/stable/) or [Flux](https://fluxcd.io/)  |
| Core Concepts Solid            | [KCNA](http://www.kcna.kp) or [CKA](https://training.linuxfoundation.org/certification/certified-kubernetes-administrator-cka/) certification   |

---

## 🎉 Congratulations – You’ve Completed the Kubernetes Learning Journey!

From *“What is Kubernetes?”* to deploying real apps — you’ve made it.

> 📘 Download your full handbook here: [!Kubernetes Made Easy eBook](https://kodekloud.com/kubernetes-made-easy?utm_term=download_the_ebook_here&utm_campaign=email_course_kubernetes&utm_medium=email&_hsenc=p2ANqtz--sXaGJdybRMe-uT6xdbdJaUeVOrqCjG6zhyKY3UDzCeNqPRCXpSiv2YErPwBsWBcpNe0Ul-96C0tCnbA9ckJO5lXJB2arHEL9SFHDdO7qwjKb5WDo&_hsmi=364567349&utm_content=email10&utm_source=hubspot)

This eBook includes:
- All 10 email lessons  
- Visuals, cheatsheets, diagrams  
- Real-world examples  
- Searchable reference format

---

## ✉️ Coming Up Next:

### 💥 “100 Days of DevOps” – Go Beyond Kubernetes

You’ll build hands-on experience with:
- Containers
- CI/CD
- Monitoring & Logging
- Cloud-native tools
- Automation with GitOps

🗓 Launches this June — don’t miss it!

👉 [Join 100 Days of DevOps](url)

---

Thank you for learning with us.  
Keep going. Keep scaling. Keep building. 🚀
