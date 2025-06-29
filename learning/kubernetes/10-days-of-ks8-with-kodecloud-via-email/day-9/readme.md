# 🧪 Day 9 – Kubernetes Probes: Is Your App *Really* Working?

You’ve deployed an app — it runs, scales, and stores data.

But Kubernetes is still asking:

> ❓ Is your app **really** working?

- Has it crashed?
- Is it still starting up?
- Is it ready to serve traffic?

Kubernetes doesn’t assume — it **checks**.

---

## ✅ Kubernetes Has 3 Types of Probes

| **Probe Type** | **Checks for...**        | **What Happens if It Fails**                |
|----------------|--------------------------|---------------------------------------------|
| `Liveness`     | Is the app alive?        | Pod is **restarted**                        |
| `Readiness`    | Is the app traffic-ready?| Pod is **removed from Service list**        |
| `Startup`      | Is the app done booting? | **Delays** liveness until startup completes |

📌 These help Kubernetes decide when to **trust, restart, or delay** your containers.

---

## 🔎 1. Liveness Probe — “Still Alive?”

Liveness Probes detect when your app is **hung or crashed**.

If it fails → the **container is restarted**.

### 📄 Example (HTTP Liveness Check)

```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 10
  periodSeconds: 5
```

➡️ Kubernetes checks `/healthz` every 5s after a 10s delay. If it fails, the Pod restarts.

Still a bit unsure about when to use a Liveness Probe?
We've broken it down step-by-step in this [Kubernetes Notes guide — check it out](https://notes.kodekloud.com/docs/Certified-Kubernetes-Application-Developer-CKAD/Observability/Liveness-Probes?utm_term=kubernetes_notes_guide&utm_campaign=email_course_kubernetes&utm_medium=email&_hsenc=p2ANqtz-_MM2HZnRM88oJv8q4pd8YVHAnKAFop-zYTjgumLNve3nzyUhxzRMqEy_GeLMfph5FhCrTjsbF-La9Mk9P5bkm1dTADLn_Csvt4QMk7_5ZktcWYxAg&_hsmi=363844383&utm_content=email9&utm_source=hubspot)

---

## 🚦 2. Readiness Probe — “Ready to Serve?”

Readiness Probes determine whether a Pod is **ready for traffic**.

If it fails:
- The Pod keeps running
- But it’s **excluded from the Service**

### 📄 Example (TCP Readiness Check)

```yaml
readinessProbe:
  tcpSocket:
    port: 5432
  initialDelaySeconds: 5
  periodSeconds: 10
```

🧪 A Pod can show `Running` in `kubectl` but still be `(0/1 Ready)` — meaning it's not getting traffic yet.

Not fully confident about Readiness Probes yet?
No worries — we've got you covered.
[Read our easy-to-follow Kubernetes Readiness Probe blog.](https://kodekloud.com/blog/kubernetes-readiness-probe/?utm_term=kubernetes_readiness_probe_blog&utm_campaign=email_course_kubernetes&utm_medium=email&_hsenc=p2ANqtz-86tKGU7Z83Y2IDslwFM_O1MxUlqB3rB3HqgEiXdPwfopx-pQ3pKOGCMzDCESsThACbxrXtACPmb1RHefJBG4TscNuOUwDIk12RZMPzv5SPuXjEt3U&_hsmi=363844383&utm_content=email9&utm_source=hubspot)

---

## 🕓 3. Startup Probe — “Still Booting?”

**Startup Probes** are used for **slow-starting apps**, like Java servers.

They **block the Liveness Probe** until the app is ready.

### 📄 Example (HTTP Startup Probe)

```yaml
startupProbe:
  httpGet:
    path: /startup
    port: 8080
  failureThreshold: 30
  periodSeconds: 5
```

➡️ App gets up to **150 seconds** (30 × 5) to boot up.

---

## 🧠 Probe Logic Flow

```
New Pod starts
    └── Startup Probe runs
        ├── If it fails → Pod restarts
        └── If it succeeds → Liveness & Readiness begin

Liveness Probe
    └── Fail → Restart Pod

Readiness Probe
    └── Fail → Remove Pod from Service
```

---

## ⚙️ Probe Field Reference

| **Field**              | **Description**                            |
|------------------------|--------------------------------------------|
| `initialDelaySeconds`  | Wait before first check                    |
| `periodSeconds`        | Time between checks                        |
| `timeoutSeconds`       | Max time to wait for a response            |
| `failureThreshold`     | Failures before Kubernetes takes action    |
| `successThreshold`     | Successes before marking Pod as healthy    |

---

## 💡 Quick Review

- Which probe protects a Pod from getting traffic too early? → **Readiness**
- Which probe waits before liveness kicks in? → **Startup**
- Which probe restarts containers when they hang? → **Liveness**

---

## 👨‍🔬 Practice Makes Perfect

> Real skills come from doing.

🎯 [Try out **Probes** hands-on in your cluster or explore a guided lab.](https://notes.kodekloud.com/docs/Certified-Kubernetes-Application-Developer-CKAD/Observability/Solution-Readiness-and-Liveness-Probes?utm_term=hands-on_solution_guide&utm_campaign=email_course_kubernetes&utm_medium=email&_hsenc=p2ANqtz--1_HhlIkxxYdc7x2WUjzSppj3cBr6VmDCdkjXTE5-k4qdCXqO6F46_AgDkn4rxU3q5Y9vcvJq3RD-4sFAdmPPSpVAR_axzLjb8OpRVk_ydMg_fHPw&_hsmi=363844383&utm_content=email9&utm_source=hubspot)

---

## 🎁 Next Week’s Special Gift

You’ll get the **final email lesson**, plus a **Kubernetes Handbook**:

✅ All 10 lessons in one place  
✅ Perfect for review before **KCNA/CKA**  
✅ Searchable + beautifully organized

---

## ✉️ Coming Up Next:

### **"Let’s Actually Build Something Real Now."**

In the final lesson, you’ll bring **everything together** to deploy a **production-grade app**.

You’re one step away from becoming **Kubernetes-capable** 🚀
