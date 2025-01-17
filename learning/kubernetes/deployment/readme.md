# Kubernetes Deployments

A **Deployment** in Kubernetes is a resource used to manage and scale a set of Pods. Deployments provide declarative updates to applications, ensuring that the desired number of Pod replicas are running and up-to-date.

## Key Features:
- **Declarative Updates**: Define the desired state of your application, and Kubernetes ensures that the current state matches it.
- **Scaling**: Easily scale applications up or down by adjusting the `replicas` field.
- **Rolling Updates**: Deployments roll out updates gradually to avoid downtime.
- **Self-healing**: Automatically replaces failed Pods to maintain the desired state.

## Example: Creating a Deployment
Below is an example YAML file to create a Deployment:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
  labels:
    app: my-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: my-container
          image: nginx:1.21
          ports:
            - containerPort: 80
```
**Breakdown:**
- `replicas`: Specifies the desired number of Pod replicas (e.g., 3).
- `selector`: Matches Pods with the label `app: my-app`.
- `template`: Describes the Pod specification:
  -  `metadata.labels`: Assigns labels to Pods for selection.
  -   `spec.containers`: Defines the container(s) inside the Pod (e.g., `nginx:1.21` with port `80`).

## Commands to use
```bash
kubectl apply -f deployment.yaml

##verify deployment
kubectl get deployments
kubectl get pods

## update deployment, you can change something from the yaml file maybe the container name and apply again
kubectl apply -f deployment.yaml

## scale deployment to 5 replicas, you can can also just change the number of replicas in yaml file
kubectl scale deployment my-deployment --replicas=5

## Delete deployment
kubectl delete deployment my-deployment
