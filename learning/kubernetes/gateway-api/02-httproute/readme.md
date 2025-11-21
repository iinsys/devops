# HTTPRoute Basics

## Understanding HTTPRoute

HTTPRoute is the core routing resource in Gateway API. It defines how HTTP traffic should be routed from a Gateway to backend services.

### Key Concepts

- **ParentRefs**: References the Gateway(s) this route attaches to
- **Hostnames**: Virtual hostnames to match
- **Rules**: List of routing rules
- **Matches**: Conditions to match requests
- **Filters**: Request/response modifications
- **BackendRefs**: Where to send matched traffic

## Example 1: Simple HTTPRoute

Routes all traffic from the Gateway to a single backend service.

## Example 2: Path-Based Routing

Routes traffic based on URL paths to different backend services.

## Example 3: Hostname-Based Routing

Routes traffic based on the Host header to different services.

## Example 4: Combined Routing

Combines path and hostname matching for complex routing scenarios.

