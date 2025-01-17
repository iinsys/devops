# Kubernetes Services

A **Service** in Kubernetes is an abstraction that defines a logical set of Pods and a policy to access them. Services provide stable network endpoints for a group of Pods, even if the Pods' IP addresses change.

## Key Features:
- **Stable IP and DNS**: Services provide a consistent IP address and DNS name for accessing Pods.
- **Load Balancing**: Distributes traffic evenly across Pods.
- **Service Types**: Determines how the Service is exposed:
  - `ClusterIP` (default): Accessible only within the cluster.
  - `NodePort`: Exposes the Service on a static port on each node.
  - `LoadBalancer`: Provisions an external load balancer (cloud-specific).
  - `ExternalName`: Maps the Service to an external DNS name.

## Example: Creating a Service
Below is an example YAML file to create a Service:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP
```
**Breakdown:**
- `selector`: Matches the Pods with the label `app: my-app`.
- `ports`: Maps the Service port (80) to the Pod's targetPort (`80`).
- `type`: Specifies the Service type (`ClusterIP`).

```bash
## apply file
kubectl apply -f service.yaml

##verify service creation
kubectl get services
