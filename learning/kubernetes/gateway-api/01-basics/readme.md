# Gateway API Basics

## Understanding GatewayClass and Gateway

### GatewayClass

GatewayClass is a cluster-scoped resource that defines a class of Gateways. It's similar to StorageClass for storage. Infrastructure providers create GatewayClasses to expose their capabilities.

### Gateway

Gateway is a namespaced resource that defines a network endpoint. It's similar to Ingress but more powerful. The Gateway resource:
- Defines listeners (ports and protocols)
- References a GatewayClass
- Can be managed by cluster operators

## Example 1: Basic Gateway Setup

This example shows how to create a simple Gateway that listens on HTTP port 80.

### Files
- `gatewayclass.yaml` - Defines the GatewayClass
- `gateway.yaml` - Defines the Gateway
- `deployment.yaml` - Sample application
- `service.yaml` - Service for the application

### Steps

1. Apply the GatewayClass (usually done by infrastructure provider)
2. Apply the Gateway
3. Deploy a sample application
4. Create an HTTPRoute to route traffic (covered in next section)

### Notes

- The GatewayClass controller name depends on your implementation (e.g., `istio.io/gateway-controller`, `konghq.com/kong`)
- Gateway must be in the same namespace as the HTTPRoute (or use ReferenceGrant for cross-namespace)
- Gateway status will show if it's been accepted and what addresses it has

