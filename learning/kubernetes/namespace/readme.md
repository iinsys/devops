# Kubernetes Namespaces

Namespaces in Kubernetes are used to organize and manage resources within a cluster. They provide a way to divide cluster resources between multiple users or teams, ensuring resource isolation and management.

## Key Features:
- **Resource Isolation**: Helps in logically separating resources like pods, services, and deployments.
- **Multi-Tenancy**: Supports multi-user environments by separating teams or projects.
- **Scoped Access**: Allows access control (via RBAC) to be applied within a specific namespace.
- **Default Namespace**: If no namespace is specified, resources are created in the `default` namespace.

## Commonly Used Namespaces:
- `default`: The default namespace for resources.
- `kube-system`: Used for system-level resources and Kubernetes components.
- `kube-public`: Accessible publicly, typically for cluster information.
- Custom namespaces: Created as per the application or team requirements.

## Example: Creating a Namespace
Below is an example YAML file to create a custom namespace:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: my-namespace
  labels:
    environment: production
```
## commands to use
```bash
## apply file
kubectl apply -f nginx-namespace.yaml
kubectl apply -f nginx-deployment.yaml

## verify namespace
kubectl get namespaces
kubectl get pods -n nginx-namespace
```