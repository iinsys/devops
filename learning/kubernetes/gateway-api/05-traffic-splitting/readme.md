# Traffic Splitting

## Overview

Traffic splitting allows you to distribute traffic across multiple backend services. This is useful for:
- Canary deployments
- A/B testing
- Gradual rollouts
- Blue-green deployments

## Key Concepts

- **Weighted BackendRefs**: Distribute traffic by percentage/weight
- **Multiple BackendRefs**: Route to multiple services with different weights
- **Total Weight**: Should typically equal 100 for clarity

## Example 1: Simple Traffic Splitting

Split traffic 80/20 between two backend services.

## Example 2: Canary Deployment

Gradually shift traffic from old to new version.

## Example 3: A/B Testing

Route traffic to different versions based on weights.

## Best Practices

- Start with small percentages (5-10%) for new versions
- Monitor metrics before increasing traffic
- Use health checks to automatically failover
- Total weights don't have to equal 100, but it's clearer if they do

