# 🧠 Who Runs Kubernetes? Meet the Control Plane

You already know what a cluster is — it's made of **Nodes running your Pods**.

But here’s the big question:

> **Who actually runs Kubernetes itself?**

### 🎯 Answer: The Control Plane — the brain of your cluster.

---

## 🧩 What Is the Control Plane?

The Control Plane is the part of Kubernetes that:

- Decides **what runs where**
- **Monitors** everything
- Responds when something **changes**
- Stores the **desired** and **actual** state of your cluster

📌 _When you type `kubectl apply`, you're talking directly to the **Control Plane**._

---

## ⚙️ Let’s Break Down Its Core Components

### 1. **API Server** – The Front Door to Your Cluster

Every `kubectl` command goes to the **API Server** first.

- Validates your request
- Stores the desired state in `etcd`

📌 _It's your interface to the cluster._

---

### 2. **etcd** – The Key-Value Database of Your Cluster

- Stores **everything**:
  - Cluster state
  - ConfigMaps
  - Secrets
  - Object definitions

📌 _You never talk to `etcd` directly — the API Server does._

---

### 3. **Controller Manager** – Keeps the Cluster in Sync

- Compares what’s **desired** (in `etcd`) vs. what’s **actually running**
- Takes corrective action when things go out of sync

📌 _Example: You want 3 Pods, only 2 are running? Controller creates the 3rd._

---

### 4. **Scheduler** – Decides Where New Pods Go

- Picks the best Node for a new Pod based on:
  - CPU/Memory availability
  - Node labels
  - Affinity rules
  - Taints and tolerations

📌 _The Scheduler doesn’t start Pods — it **assigns** them. The **kubelet** on the Node handles creation._

---

### 5. **Cloud Controller Manager** *(Optional)* – Cloud Integration

- Used in **cloud environments** (AWS, GCP, Azure)
- Manages:
  - Load Balancers
  - Storage
  - Cloud metadata sync

📌 _Not used in local clusters like `minikube` or `kind`._

---

## 📸 Summary Snapshot

| Component             | Role                                           |
|------------------------|------------------------------------------------|
| **API Server**         | Front door, validates & processes all requests |
| **etcd**               | Stores cluster state and configuration         |
| **Controller Manager** | Syncs actual state with desired state          |
| **Scheduler**          | Assigns Pods to Nodes                          |
| **Cloud Controller**   | Connects to cloud provider APIs _(optional)_   |

---

## ❓ Quick Quiz: Can You Match These?

Match the Kubernetes components to what they do:

1. Stores every object in the cluster → _______  
2. Assigns a Pod to a Node → _______  
3. You interact with it via kubectl → _______  
4. Notices if a Node goes down → _______

📝 _Jot down your answers somewhere — don’t peek online just yet._  
🕵️ The answers will be revealed in the next lesson.

---

## 👁️ Want to See It Visually?
![Architecture](./unnamed.png)

> Found the Kubernetes Architecture image helpful?

📍 _Explore more visual maps and infographics on the_  
**[KodeKloud DevOps 101 GitHub Repository](https://github.com/kodekloudhub/devops-101/blob/main/Kubernetes/Kubernetes%20Architecture%20Knowledge%20Map.md?utm_term=kodekloud_devops_101_github_repository&utm_campaign=email_course_kubernetes&utm_medium=email&_hsenc=p2ANqtz-9_lI54F5nMtu-r3ysjJG_2NaJ32XvGT3F9tUd71OK3vBNTaAjSMsqSAACcqDKcfx5LdB5VbtwnH2Ri7pE9JuRtSt33SQRzcQ3vq1MPK2jQMbbLzVE&_hsmi=362720501&utm_content=email3&utm_source=hubspot)**  
⭐ Bookmark it and give it a star if you find it helpful!

---

## 🎥 Recommended Resource

🎬 **Watch:** [_Kubernetes Architecture in 10 Minutes_](https://www.youtube.com/watch?v=klxZke9qbvg) 
By **Mumshad Mannambeth** on the KodeKloud YouTube channel

🧠 Great for solidifying your mental model of how Kubernetes works behind the scenes.

---

## 📚 Further Reading

Prefer reading or want to explore at your own pace?

- [Kubernetes Architecture Overview](https://kodekloud.com/blog/kubernetes-architecture-overview/?utm_term=kubernetes_architecture_overview&utm_campaign=email_course_kubernetes&utm_medium=email&_hsenc=p2ANqtz--lRb104ZoRcs8LdoQH4U7Ch9wyFJFC5loHwWu8kV9E9ED4Hb0DSHS8g4tXETzwqbn4cz9vfEcl4kkj4hAccVusSUt6RORsVCXH3-ijo2omW2lF45M&_hsmi=362720501&utm_content=email3&utm_source=hubspot)
- [Kubernetes Concepts Explained](https://kodekloud.com/blog/kubernetes-concepts-explained/?utm_term=kubernetes_concepts_explained&utm_campaign=email_course_kubernetes&utm_medium=email&_hsenc=p2ANqtz-_dQqRyqxXZrNkWmv8Xdg7DyF64uoGw0Qs4HDxMTYzXPXswqdVHy6uiwyU_CrN2sppwE5AxXgzLO4uB9zVgbePq9w51FrT5OGX-KU363RZsth1CQ6A&_hsmi=362720501&utm_content=email3&utm_source=hubspot)

---

## ✉️ Coming Up Next

> **"You Typed `kubectl apply`. What Really Happens Next?"**

We’ll walk you through the full journey — from a **YAML file** to a **live Pod** inside your cluster.

🚀 _Keep going — you're learning what most engineers miss!_
