common commands
Destroying the infrastructure.
```bash
tf destroy -auto-approve

tf fmt ## formatting file

ssh -i "auto-generated-key.pem" ubuntu@<public_ip_of instance>
```
A datasource is just a query to the aws api to receive information needed to deploy a resource