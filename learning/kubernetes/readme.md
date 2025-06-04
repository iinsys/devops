# Kubernetes Learning Path

This guide provides a recommended order for learning Kubernetes as a beginner, with links to each topic's folder for hands-on practice. Follow this sequence for a solid foundation:

1. **Pods**  
   [pod/](./pod/)  
   Learn about the basic unit of deployment in Kubernetes.

2. **ReplicaSets**  
   [replicaset/](./replicaset-expl/)  
   Understand how to maintain a stable set of replica Pods.

3. **Deployments**  
   [deployment/](./deployment/)  
   Manage stateless applications and rolling updates.

4. **Namespaces**  
   [namespace/](./namespace/)  
   Organize resources and provide scope for names.

5. **Services**  
   [service/](./service/)  
   Expose your applications and enable communication.

6. **ConfigMaps & Secrets**  
   [configmap-secret/](./configmap-secret/)  
   Manage configuration and sensitive data.

7. **StatefulSets**  
   [statefulset/](./statefulset/)  
   Deploy and manage stateful applications.

8. **Persistent Volumes & Claims**  
   [persistent-volume/](./persistent-volume/)  
   Handle storage for your workloads.

9. **Jobs & CronJobs**  
   [job/](./job/)  
   [cronjob/](./cronjob/)  
   Run batch and scheduled tasks.

10. **DaemonSets**  
    [daemon-set/](./daemon-set/)  
    Ensure a copy of a pod runs on all (or some) nodes.

11. **Horizontal Pod Autoscaler (HPA)**  
    [hpa/](./hpa-sb/)  
    Automatically scale your pods based on metrics.

12. **Network Policies**  
    [network-policy/](./network-policy/)  
    Control network access to and from your pods.

13. **Resource Quotas & Limits**  
    [resource-quota/](./resource-quota/)  
    Limit resource usage in namespaces.

14. **Pod Disruption Budgets**  
    [pod-disruption-budget/](./pod-disruption-budget/)  
    Maintain high availability during disruptions.

15. **Init Containers**  
    [init-container/](./init-container/)  
    Run setup tasks before app containers start.

16. **Affinity & Anti-Affinity**  
    [affinity/](./affinity/)  
    Control pod placement on nodes.

17. **RBAC (Role-Based Access Control)**  
    [rbac/](./rbac/)  
    Manage permissions and access control.

18. **Ingress**  
    [ingress/](./ingress/)  
    Expose HTTP and HTTPS routes from outside the cluster.

19. **Custom Resource Definitions (CRD) & Operators**  
    [crd/](./crd/)  
    [operator/](./operator/)  
    Extend Kubernetes with custom resources and controllers.

20. **Admission Webhooks**  
    [admission-webhook/](./admission-webhook/)  
    Intercept and validate or mutate requests to the Kubernetes API.

---

> **Tip:** Each folder contains a `readme.md` with explanations and hands-on commands. Start from the top and work your way down for a comprehensive Kubernetes learning experience!