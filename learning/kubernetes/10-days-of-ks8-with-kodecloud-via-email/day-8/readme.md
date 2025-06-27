# 🎉 Day 8/10 – Kubernetes Configs, Secrets & Volumes

We’ve come a long way together over the past 8 days, diving into Kubernetes — with practical, bite-sized lessons perfect for KCNA, CKA, or real-world readiness.

---

📘 **Good News!** A **Kubernetes Handbook** bundling all 10 lessons is coming!

To get your copy, just fill out the short feedback form sent via email. Your thoughts will help shape even better learning journeys.

---

## 🚀 Today’s Focus: ConfigMaps, Secrets & Volumes

You’ve deployed your app using a **Deployment** — it scales, updates, and rolls back.

But now we need to:

- Load configs from files or environment variables
- Inject secrets securely
- Persist data across restarts

Let’s dive into:

---

## 🔧 1. ConfigMap — For Plain Configuration

A **ConfigMap** lets you store:

- Key-value pairs
- Environment variables
- App settings and arguments

📌 Use it for **non-sensitive** data.

### 📝 Example ConfigMap
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  APP_MODE: "production"
  APP_PORT: "8080"
```

### 🧪 Use it in a Pod
```yaml
envFrom:
  - configMapRef:
      name: app-config
```
➡️ Now your app receives `APP_MODE` and `APP_PORT` as environment variables.

---

## 🔐 2. Secret — For Sensitive Data

**Secrets** are like ConfigMaps, but base64-encoded and encrypted.

Use Secrets to store:

- Passwords
- API tokens
- TLS certificates

📌 Never hardcode sensitive values in specs or images.

### 📝 Example Secret
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-secret
type: Opaque
data:
  username: YWRtaW4=     # 'admin'
  password: cGFzc3dvcmQ= # 'password'
```

### 🧪 Use it in a Pod
```yaml
env:
  - name: DB_USER
    valueFrom:
      secretKeyRef:
        name: db-secret
        key: username
```
➡️ Securely injects values without exposing them in plain YAML.

---

## 💾 3. Volumes — For Persisting or Sharing Data

**Volumes** give containers access to storage.

Use volumes to:

- Save data across restarts
- Share data between containers
- Mount ConfigMaps or Secrets as files

### 📝 Example: Mount ConfigMap as Files
```yaml
volumes:
  - name: config-volume
    configMap:
      name: app-config
containers:
  - name: app
    volumeMounts:
      - name: config-volume
        mountPath: /etc/config
```
📌 Each key becomes a file under `/etc/config`

---

## 🗂️ Common Volume Types

| Volume Type           | Use Case                          |
|------------------------|-----------------------------------|
| `emptyDir`             | Scratch space (reset on restart)  |
| `hostPath`             | Mounts host folder (⚠ use cautiously) |
| `configMap`            | Mount config as files             |
| `secret`               | Mount secrets as files            |
| `persistentVolumeClaim`| Durable disk (DBs, logs, etc.)    |

---

## 🧠 Summary Table

| Feature     | Purpose               | Common Use Case              |
|-------------|------------------------|-------------------------------|
| **ConfigMap** | Inject config data     | Env vars, app settings        |
| **Secret**    | Inject sensitive data  | API keys, passwords, TLS certs |
| **Volume**    | Share/persist data     | Config files, logs, DB storage |

---

## 💡 Quick Review

- Which resource injects API keys? → **Secret**
- How do you mount config values as files? → **Use a Volume**
- Do ConfigMaps store encrypted data? → **No**

---

## 📚 Want to Master Kubernetes Secrets?

- 🔗 [**CKAD Notes on Kubernetes Secrets**](https://notes.kodekloud.com/docs/Certified-Kubernetes-Application-Developer-CKAD/Configuration/Secrets?utm_term=read_the_ckad_notes_on_kubernetes_secrets&utm_campaign=email_course_kubernetes&utm_medium=email&_hsenc=p2ANqtz--nHGAppCkkAz6oJ8QSZhUJQZfDSloWXttmD20BzmrTFRGXmjCir_8v_xC1wbkm6gU23uaWGW64GxB3d80NmK9ovTimlNC1PUnmAq03_bevSKna1P0&_hsmi=362722105&utm_content=email8&utm_source=hubspot)

- 🔗 [**KodeKloud Blog: Kubernetes Secrets Deep Dive**](https://kodekloud.com/blog/kubernetes-secrets/?utm_term=read_the_kodekloud_blog_on_kubernetes_secrets&utm_campaign=email_course_kubernetes&utm_medium=email&_hsenc=p2ANqtz-_6VVN1gc1rhgy-QgTWkBEoOUjCNgSyOGom3R4t6DOGlwWvjRuS0nFiV_uFZ8rav7l9j7L9lwDnYD9vYZOHRnUwJRjh48M__lE6c3Jwiy-yWjMzR0E&_hsmi=362722105&utm_content=email8&utm_source=hubspot)

---

## ✉️ Coming Up Next:

**"Your App Is Running… But Is It Working?"**

Next, we’ll explore **health checks**, **liveness probes**, and **readiness gates** so Kubernetes knows when your app is really ready.

You’re almost at production-grade Kubernetes. One step left 🚀
