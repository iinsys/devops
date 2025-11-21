# Core Architecture

kubelet: 
- CLI for k8s cluster
- Install on ubuntu, homebrew, macports, powershell, chocolatey,  redhat
- Kubeconfig file: allows you to get access to the cluster

API Server:
- Central management entity of the cluster, it is like the door of the cluster
- The only component that directly connects to etcd.
- Core functionality is truly as an "API":
  - External: via kubelet
  - Nodes: via kubelet which runs on each node
  - Persistent state of objects via: etcd.

etcd:
 is a strongly consistent, distributed key-value store that provides a reliable way to store data that needs to be accessed by a distributed system or cluster of machines. It gracefully handles leader elections during network partitions and can tolerate machine failure, even in the leader node.

- Stores and replicats all cluster state
- Primary datastore for kubernetes
- Runs in high availability mode(3 of them):
  - Requires a quorum for following:
  - Elect a new ETCD member
  - Update datastore

Scheduler: 
- Plays "Tertris" on all nodes
- Once the pods is placed on a node the scheduler is done.
- Kubelet then takes over and deploy and observes the pod

Controller-Manager: 
- A daemon that embeds controllers inside the master node, such as:
  - replication controller
  - endpoint controller
  - namespace controller
  - serviceaccounts controller


kubelet: 
- Present on every single node inside your cluster
- Focus on running containers
- Runs all nodes
- Pods are defined by JSON or YAML file called the 
 - The pods manifest 
- Has an internal HTTP, server:
  - Reads-view on port 10225
  - Kubelet URLS that can curl: 
   - /health - Health check
   - /pods
   - /spec

Container runtime: 
- Found inside every node
- Responsible for all the docker stuffs docker pull and so on, 
- can still be another container runtime engine apart from docker

