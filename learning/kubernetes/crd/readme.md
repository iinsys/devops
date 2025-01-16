# Custom Defined Resources (CDR) in Kubernetes

## What are CDRs?
- CDRs in Kubernetes are extensions to the Kubernetes API that allow users to define their own resource types.
- They are commonly implemented using **CustomResourceDefinitions (CRDs)**, enabling you to manage and interact with these custom resources via the Kubernetes API.

## Use Cases
1. **Application-Specific Configurations**: Define and manage application-specific resources like `KafkaTopic` or `MySQLCluster`.
2. **Custom Workflows**: Automate and orchestrate workflows beyond Kubernetes' built-in resources.
3. **Extending Kubernetes**: Add domain-specific objects and logic to Kubernetes clusters.

## Key Components
1. **CustomResourceDefinition (CRD)**:
   - A YAML manifest used to define a custom resource's schema and behavior.
2. **Custom Resources**:
   - Instances of the CRD that represent the custom objects.
3. **Controller** (optional but common):
   - Watches for changes in custom resources and acts on them to reconcile the desired state.

## Example: Defining a CRD
Below is an example of a simple CRD for managing a `Database` resource.

```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: databases.example.com
spec:
  group: example.com
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                size:
                  type: string
                engine:
                  type: string
  scope: Namespaced
  names:
    plural: databases
    singular: database
    kind: Database
    shortNames:
    - db
```
## Creating my own crd, that can be used to create a book resource
```bash
#apply file to create crd
kubectl apply -f book-crd.yaml
kubectl get crds

## create a bookd resource from my library crd
kubectl apply -f book-resource.yaml

## verify book creation
kubectl get books
kubectl describe book war-and-peace

## flex
kubectl delete book war-and-peace
kubectl edit book war-and-peace
kubectl delete book war-and-peace
kubectl delete crd books.library.bansikah.com
```

