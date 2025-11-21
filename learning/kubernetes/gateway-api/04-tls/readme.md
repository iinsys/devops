# TLS/SSL Termination

## Overview

Gateway API supports TLS termination at the Gateway level. This allows you to:
- Terminate TLS connections
- Use multiple TLS certificates
- Configure TLS settings per listener

## Key Concepts

- **TLS Mode**: Terminate (default) or Passthrough
- **CertificateRefs**: References to TLS secrets
- **Hostname**: SNI (Server Name Indication) matching

## Example 1: Basic TLS Termination

Terminate TLS at the Gateway using a Kubernetes secret containing the certificate.

## Example 2: Multiple TLS Certificates

Use different certificates for different hostnames.

## Example 3: TLS Passthrough

Pass TLS connections through to backend services without termination.

## Prerequisites

You'll need TLS certificates. For testing, you can:
- Use cert-manager to generate certificates
- Use self-signed certificates
- Use Let's Encrypt certificates

