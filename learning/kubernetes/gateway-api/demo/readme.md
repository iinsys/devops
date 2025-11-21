# Gateway API Demo

This is a simple demo to get started with Gateway API on minikube.

## Files

- `gatewayclass.yaml` - Defines the GatewayClass
- `gateway.yaml` - Defines the Gateway (network endpoint)
- `deployment.yaml` - Sample web application
- `service.yaml` - Service for the web application
- `httproute.yaml` - HTTPRoute that connects Gateway to Service

## Quick Start

```bash
# Apply all resources
kubectl apply -f .

# Check status
kubectl get gateway
kubectl get httproute
kubectl get svc webapp

# Get Gateway address (may take a moment to get an IP)
kubectl get gateway example-gateway -o jsonpath='{.status.addresses[0].value}'
```

## Testing

Once the Gateway has an address assigned:

```bash
# Get the Gateway IP
GATEWAY_IP=$(kubectl get gateway example-gateway -o jsonpath='{.status.addresses[0].value}')

# Test the route
curl http://$GATEWAY_IP
```

If using minikube and the Gateway doesn't get an external IP, you can use port-forward:

```bash
# Find the Gateway service (depends on your implementation)
kubectl get svc -A | grep gateway

# Port forward
kubectl port-forward -n <gateway-namespace> svc/<gateway-service> 8080:80

# Test
curl http://localhost:8080
```

