23. Open Search Setup Using Terraform

>The best way to guarantee a loss is to quit.
>
>– Morgan Freeman

The Nautilus DevOps team needs to set up an Amazon OpenSearch Service domain to store and search their application logs. The domain should have the following specification:

1) The domain name should be `xfusion-es`.

2) Use Terraform to create the `OpenSearch domain`. The Terraform working directory is `/home/bob/terraform`. Create the `main.tf` file (do not create a different `.tf` file) to accomplish this task.


`Notes:`

- The Terraform working directory is `/home/bob/terraform`.

- `Right-click` under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

- Before submitting the task, ensure that terraform plan returns `No changes. Your infrastructure matches the configuration`.

- The OpenSearch domain creation process may take several minutes. Please wait until the domain is fully created before submitting.

## Solution
```bash
terraform init

terraform plan

terraform apply --auto-approve

terraform plan

terraform apply --auto-approve

terraform plan

```

# 📘 Brief Overview: AWS OpenSearch and Terraform Resources

## 🔍 What is AWS OpenSearch?

**AWS OpenSearch Service** is a managed service that makes it easy to deploy, operate, and scale **OpenSearch** clusters in the AWS Cloud. OpenSearch is a search and analytics engine, used for:

- Full-text search  
- Log and event data analysis  
- Real-time application monitoring  
- Security and observability use cases  

It is the open-source fork of **Elasticsearch** and **Kibana** (originally developed by Elastic), now maintained by **AWS** and the **OpenSearch community**.

---

## 🏗️ Resources Created with Terraform

When provisioning an OpenSearch domain using Terraform, the following key AWS resources are configured:

| Resource                      | Purpose                                                              |
|------------------------------|----------------------------------------------------------------------|
| `aws_opensearch_domain`      | Main resource that provisions the OpenSearch domain (cluster).       |
| `domain_name`                | Unique identifier for the domain (e.g., `xfusion-es`).               |
| `engine_version`             | Specifies the OpenSearch version (e.g., `OpenSearch_2.11`).          |
| `cluster_config`             | Defines instance type, count, and whether it's a multi-AZ deployment.|
| `ebs_options`                | Configures storage: EBS volume size, type (e.g., `gp2`), etc.        |
| `access_policies`            | IAM-style JSON policy to control who can access the domain.          |
| `tags`                       | Optional key-value metadata for identification and billing.          |

---

## ✅ Example: What Your Configuration Creates

- Domain Name: `xfusion-es`
- Instance Count: `1`
- Instance Type: `t3.small.search`
- EBS Volume Size: `10 GB`
- EBS Volume Type: `gp2`
- Access Policy: `Public (for testing only)`
- OpenSearch Engine: `OpenSearch_2.11`


> ⚠️ **Note:** For production use, ensure you tighten access policies and consider enabling encryption and fine-grained access control.
