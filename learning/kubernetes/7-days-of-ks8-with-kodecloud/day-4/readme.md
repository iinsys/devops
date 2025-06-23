# 📘 Before We Dive Into Today’s Lesson…

_Last time, we left you with a quick mini-quiz. Let’s reveal the answers!_

## 🔍 Quiz Recap & Answers:
- Stores every object in the cluster → ✅ `etcd`  
- Assigns a Pod to a Node → ✅ `Scheduler`  
- You interact with it via `kubectl` → ✅ `API Server`  
- Notices if a Node goes down → ✅ `Controller Manager`

🎯 _If you got 3 or more right — you're seriously leveling up your Kubernetes knowledge!_

---

## 🚀 Today’s Topic: What Happens When You Run `kubectl apply`?

You’ve probably run something like this before:

```bash
kubectl apply -f my-pod.yaml
```

But… what actually happens after that?

Let’s walk through the **behind-the-scenes journey** — step by step — from YAML to a running container.

---

## 🧩 Step 1: Your YAML Hits the API Server

Your Pod definition is sent to the **API Server**, which is the **front door of your cluster**.

### 🔧 The API Server:
- Validates the YAML (syntax, required fields)
- Returns an error if anything is invalid
- If valid, passes it forward

📌 _All requests in Kubernetes go through the API Server._

---

## 🗄️ Step 2: API Server Stores It in `etcd`

Once validated, the API Server saves the desired state:

> "A Pod named `my-pod` should exist in the cluster."

That state is stored in `etcd` — the **database of your cluster**.

---

## 👀 Step 3: Controller Notices Something’s Missing

The **Controller Manager** continuously watches the cluster state.

It detects:
> “There’s a record in `etcd` saying this Pod should exist… but I don’t see it running.”

So, it **triggers the next step**: Pod scheduling.

---

## 📦 Step 4: Scheduler Picks the Best Node

The **Scheduler** kicks in. It checks:

- CPU/memory availability  
- Node labels and affinity  
- Taints and tolerations  

Then it selects a **Worker Node** and tells the API Server to **bind** the Pod to that Node.

📌 _The Scheduler doesn’t create Pods — it just assigns them._

---

## ⚙️ Step 5: Kubelet on the Node Takes Over

The `kubelet` (the agent running on that Node) gets the assignment.

It:
- Pulls the container image (via `containerd`)
- Starts the container(s)
- Monitors the Pod’s health

🚨 If something goes wrong (e.g., image not found), **kubelet** reports the error.

---

## ✅ Step 6: Pod Is Running!

Once everything works:
- The Pod is marked as **Running**
- You can confirm with:

```bash
kubectl get pods
```

---

## 📜 Full Pod Creation Summary

| Step | What Happens                    | Component Involved       |
|------|----------------------------------|---------------------------|
| 1    | YAML sent                        | `kubectl` → `API Server` |
| 2    | State stored                     | `API Server` → `etcd`    |
| 3    | Pod creation detected            | `Controller Manager`     |
| 4    | Node selected for the Pod        | `Scheduler`              |
| 5    | Pod created, image pulled        | `kubelet` on Node        |
| 6    | Pod enters Running state         | `kubelet` + `containerd` |

---

## 🧪 Try These Commands

```bash
kubectl apply -f my-pod.yaml           # Create the Pod
kubectl get pods                       # Check Pod status
kubectl describe pod my-pod            # View detailed events
kubectl get events --sort-by=.metadata.creationTimestamp
```

---

## 🎯 Quick Quiz Before We Wrap Up:

**You applied a Pod, but the image failed to pull.  
Which Kubernetes component reports this error?**

> Think you know it? Hold that thought.  
> We’ll reveal the correct answer at the beginning of our next email!

---

## 🎓 Want to Go Even Deeper on Pods?

🔖 **Read**: *What Are Pods in Kubernetes?*  
➡️ [_A super beginner-friendly breakdown from KodeKloud._](https://kodekloud.com/blog/day-2-what-are-pods-in-kubernetes/?utm_term=what_are_pods_in_kubernetes_kodekloud_blog&utm_campaign=email_course_kubernetes&utm_medium=email&_hsenc=p2ANqtz--81ZDkDYNuV1u4s5bIJNmpDWHoAIAZx0bMJYIIUYGeBkuzu-sRvPjtgr_thyNs30bJcIkFJpNSos0TiloQwuoWVDNVgqhsAnA53-AYr05JeOLzxqo&_hsmi=362718387&utm_content=email4&utm_source=hubspot)

🎥 **Watch**: [*Kubernetes: Pod Definition with YAML (YouTube - Mumshad)*](https://www.youtube.com/watch?v=T6E2yzlEX0Q)  
➡️ _Follow along step-by-step as you define a real Pod._

🧪 **Practice**: [*KodeKloud Free Pods Lab*](https://kodekloud.com/free-labs/kubernetes?utm_term=explore_the_kubernetes_services_labs&utm_campaign=email_course_kubernetes&utm_medium=email&_hsenc=p2ANqtz-8ry9FL1ybE7np-EpytW4b_F7EphSh9Z6kfLOBwUB7kP0Mr8IqQytLuvravfYNR2DGGTkTmqyaPOx5yh9TgXCGLtnlgpEpCvdFaIu8Owx1xAcx6wpc&_hsmi=362721068&utm_content=email5&utm_source=hubspot)  
➡️ _Spin up Pods right now — no setup required._

---

## ✉️ Coming Up Next:

> “Your Pod Is Running… But Who Can Reach It?”

We’ll explore **Services** — the stable way to expose your apps inside (and outside) the cluster.

🚀 _You’re doing great — keep going!_
