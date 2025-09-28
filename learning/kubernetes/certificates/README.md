# How to debug Kubernetes Ingress? (TLS - Cert-Manager - HTTP-01 & DNS-01 Challenges)

This project demonstrates debugging Kubernetes Ingress with TLS certificates using cert-manager and both HTTP-01 and DNS-01 ACME challenges.

Based on the tutorial: [How to debug Kubernetes Ingress?](https://youtu.be/DJ2sa49iEKo)

## Project Structure

```
certificates/
├── terraform/          # Infrastructure as Code
│   ├── 0-locals.tf     # Local variables
│   ├── 1-providers.tf  # Terraform providers
│   ├── 2-vpc.tf        # VPC and networking
│   ├── 3-eks.tf        # EKS cluster
│   ├── 4-nodes.tf      # EKS node groups
│   ├── 5-helm.tf       # Helm provider configuration
│   ├── 6-nginx-ingress.tf  # NGINX Ingress Controller
│   ├── 7-cert-manager.tf   # Cert-Manager installation
│   ├── 8-irsa.tf       # IAM Roles for Service Accounts
│   ├── 9-dns-manager-iam.tf # DNS-01 challenge IAM
│   └── values/
│       └── nginx-ingress.yaml
├── 1-example/          # HTTP-01 Challenge Example
│   ├── 0-cluster-issuer.yaml
│   ├── 1-deployment.yaml
│   ├── 2-service.yaml
│   └── 3-ingress.yaml
├── 2-example/          # DNS-01 Challenge Example
│   ├── 0-cluster-issuer.yaml
│   ├── 1-deployment.yaml
│   ├── 2-service.yaml
│   └── 3-ingress.yaml
└── README.md
```

## Prerequisites

- AWS CLI configured
- kubectl installed
- Terraform installed
- A domain name for testing (optional but recommended)

## Quick Start

### 1. Deploy Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 2. Configure kubectl

```bash
aws eks update-kubeconfig --region us-east-2 --name dev-demo
```

### 3. Verify cluster

```bash
kubectl get nodes
kubectl get pods -A
```

### 4. Test HTTP-01 Challenge (Example 1)

```bash
# Apply the HTTP-01 example
kubectl apply -f 1-example/

# Check certificate status
kubectl get certificates
kubectl describe certificate myapp-tls

# Check challenge status
kubectl get challenges
kubectl describe challenge <challenge-name>

# Check ingress
kubectl get ingress
```

### 5. Test DNS-01 Challenge (Example 2)

**Note:** Requires AWS Route53 hosted zone and proper IAM permissions.

```bash
# Apply the DNS-01 example
kubectl apply -f 2-example/

# Check certificate status
kubectl get certificates
kubectl describe certificate myapp-dns01-tls

# Check challenge status
kubectl get challenges
kubectl describe challenge <challenge-name>

# Check ingress
kubectl get ingress
```

## Certificate Challenges

### HTTP-01 Challenge (1-example)

- **Use case**: Simple domain validation
- **Requirements**: Domain must be publicly accessible
- **How it works**: Creates temporary ingress to serve challenge response
- **Limitations**: Cannot issue wildcard certificates

### DNS-01 Challenge (2-example)

- **Use case**: Wildcard certificates, private domains
- **Requirements**: DNS provider API access (Route53 in this case)
- **How it works**: Creates DNS TXT record for validation
- **Benefits**: Works with private networks, supports wildcards

## Debugging Tips

### Common Issues

1. **Certificate stuck in "Pending"**
   ```bash
   kubectl describe certificate <cert-name>
   kubectl describe order <order-name>
   kubectl describe challenge <challenge-name>
   ```

2. **HTTP-01 Challenge fails**
   - Check ingress controller is running
   - Verify domain points to load balancer
   - Check firewall rules (port 80 must be accessible)

3. **DNS-01 Challenge fails**
   - Verify IAM permissions for Route53
   - Check service account annotations
   - Verify DNS zone exists

### Useful Commands

```bash
# Check cert-manager pods
kubectl get pods -n cert-manager

# Check cert-manager logs
kubectl logs -n cert-manager deployment/cert-manager

# Check ingress controller
kubectl get pods -n ingress

# List all certificates
kubectl get certificates -A

# List all issuers
kubectl get clusterissuers

# Check ingress status
kubectl describe ingress <ingress-name>
```

## Configuration

### Environment Variables

- `AWS_REGION`: AWS region (default: us-east-2)
- `CLUSTER_NAME`: EKS cluster name (default: dev-demo)

### Customization

1. **Update domain names** in ingress files
2. **Modify email address** in cluster issuer files  
3. **Adjust resource limits** in deployment files
4. **Update DNS zone** for DNS-01 challenges

## Cleanup

```bash
# Delete examples
kubectl delete -f 1-example/
kubectl delete -f 2-example/

# Destroy infrastructure
cd terraform
terraform destroy
```

## Troubleshooting

### Certificate Manager Issues

1. **Check CRDs are installed**
   ```bash
   kubectl get crd | grep cert-manager
   ```

2. **Verify webhook is running**
   ```bash
   kubectl get pods -n cert-manager
   ```

### Ingress Issues

1. **Check ingress class**
   ```bash
   kubectl get ingressclass
   ```

2. **Verify load balancer**
   ```bash
   kubectl get svc -n ingress
   ```

## References

- [Cert-Manager Documentation](https://cert-manager.io/docs/)
- [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/)
- [Let's Encrypt ACME Challenges](https://letsencrypt.org/docs/challenge-types/)
- [Original Tutorial](https://youtu.be/DJ2sa49iEKo)