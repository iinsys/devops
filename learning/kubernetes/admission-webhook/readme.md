# Admission Webhook Example (Dummy)

This directory demonstrates a minimal validating admission webhook configuration in Kubernetes. In production, you would use a real webhook server, but this example is for structure and testing only.

## Prerequisites
- Minikube cluster running
- kubectl configured

## Testing Steps

1. Deploy the dummy webhook server:
```bash
kubectl apply -f webhook-deployment.yaml
```

2. Deploy the webhook configuration:
```bash
kubectl apply -f webhook-config.yaml
```

3. Try to create a pod (may be rejected or ignored since this is a dummy server):
```bash
kubectl run test-pod --image=nginx:alpine
```

4. Check events and webhook status:
```bash
kubectl get validatingwebhookconfigurations
kubectl describe validatingwebhookconfiguration dummy-webhook
```

## Cleanup
```bash
kubectl delete -f webhook-config.yaml
kubectl delete -f webhook-deployment.yaml
```

## Note
- For a real webhook, you would need a custom server that implements the admission review API and a valid TLS certificate.
- This example is for learning and structure only.
