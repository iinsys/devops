# Path-Based Routing

This example demonstrates routing traffic to different backend services based on URL paths.

## Scenario

- `/api` routes to an API service
- `/web` routes to a web frontend service
- `/` (default) routes to a default service

## Files

- `api-deployment.yaml` - API backend service
- `api-service.yaml` - Service for API
- `web-deployment.yaml` - Web frontend service
- `web-service.yaml` - Service for web
- `default-deployment.yaml` - Default backend service
- `default-service.yaml` - Service for default
- `httproute.yaml` - HTTPRoute with path-based rules

## Testing

After applying all resources:

```bash
# Test API route
curl http://<gateway-address>/api

# Test web route
curl http://<gateway-address>/web

# Test default route
curl http://<gateway-address>/
```

