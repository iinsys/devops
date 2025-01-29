managing secrets with tf vars

make sure to create a terraform.tfvars file with the following
```tf
mysql_username = "myusername"
mysql_password = "mypassword"
```
apply fils
```bash
tf init
tf plan
tf apply
```