# Kubernetes

Kubernetes, also known as K8s, is an open source system for automating deployment, scaling, and management of containerized applications.

It groups containers that make up an application into logical units for easy management and discovery. Kubernetes builds upon 15 years of experience of running production workloads at Google, combined with best-of-breed ideas and practices from the community.

## Key Features

### Planet Scale
Designed on the same principles that allow Google to run billions of containers a week, Kubernetes can scale without increasing your operations team.

### Never Outgrow
Whether testing locally or running a global enterprise, Kubernetes flexibility grows with you to deliver your applications consistently and easily no matter how complex your need is.

### Run K8s Anywhere
Kubernetes is open source giving you the freedom to take advantage of on-premises, hybrid, or public cloud infrastructure, letting you effortlessly move workloads to where it matters to you.

## Kubernetes Features

1. **Automated rollouts and rollbacks**
2. **Service discovery and load balancing**
3. **Storage orchestration**
4. **Self-healing**
5. **Secret and configuration management**
6. **Automatic bin packing**
7. **Batch execution**
8. **Horizontal scaling**
9. **IPv4/IPv6 dual-stack**
10. **Designed for extensibility**

## Upcoming Events

- KubeCon + CloudNativeCon China: August 21-23
- KubeCon + CloudNativeCon North America: November 12-15
- KubeCon + CloudNativeCon India: December 11-12

## Case Studies

"Kubernetes is a great platform for machine learning because it comes with all the scheduling and..."

"Kubernetes is a great solution for us. It allows us to rapidly iterate on our clients' demands."

For more information and to download Kubernetes, visit the [official Kubernetes website](https://kubernetes.io).


# GCP Kubernetes Cluster Requirements

## General Cluster Requirements

- **Platform**: Google Kubernetes Engine (GKE)
- **Kubernetes Version**: 1.30 (or the latest stable version)
- **Node Types**: Choose appropriate node types based on workload requirements (e.g., e2-standard, n2-standard)

## Data Storage

- **Deployment application**: Cloud Storage (GCS)
- **Persistent Volumes**: Persistent Disk (PD)

## Namespaces

- **xs2a**: dev, support
- **sandbox**: dev, support
- **qwac**: dev

## Required Resources

| Namespace | CPU | RAM |
|-----------|-----|-----|
| xs2a      | 4   | 8GB |
| sandbox   | 6   | 12GB|
| qwac      | 2   | 4GB |

*Note: Resources are per 1 NS*

## Minimum Node Requirements

- **Total**: 22 CPU, 44GB RAM
- **Node Type**: Choose appropriate node types (e.g., e2-standard-2, n2-standard-4)

## Internal Cluster Services

- **Helm Repository**: Artifact Registry
- **Application Load Balancer**: GCP Load Balancer
- **External DNS**: Cloud DNS
- **Ingress Controller**: GKE Ingress Controller
- **DNS Zone**: Hosted in Cloud DNS
- **SSL Certificates**: Cloud Certificate Manager (CCM)

## Monitoring and Performance

- **Monitoring Tools**: Stackdriver Monitoring, Prometheus, or third-party tools
- **Monitoring of Nodes and Internal Pods**: Use Stackdriver Monitoring or Prometheus

## Access Policies (RBAC)

- **DevOps**: Full deployment access
- **Developers**: Access to application logs
- **Bots**: For deploying and tests

## Future Plans

- Implement end-to-end testing for xs2a, sandbox, and qwac namespaces

## Key Differences from Previous Setup

- **Storage**: Replace EFS with Cloud Storage (GCS) and EBS with Persistent Disk (PD)
- **Internal Services**: Use GCP-specific services like Artifact Registry, Cloud DNS, and Cloud Certificate Manager
- **Monitoring**: Leverage Stackdriver Monitoring for comprehensive monitoring

This setup leverages GCP's managed services, scalability, and performance capabilities.