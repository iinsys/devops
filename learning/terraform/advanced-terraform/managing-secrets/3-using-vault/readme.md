Use this link to install vault, my system to be specific was linux [install vault](https://developer.hashicorp.com/vault/install)

```bash
# Add HashiCorp GPG key
wget -O - https://apt.releases.hashicorp.com/gpg | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# Add HashiCorp repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update package index
sudo apt update

# Install Vault
sudo apt install vault -y
vault --version
vault server -dev

vault secrets enable -path=secret kv ## you should see an error but its fine, becasue when we started the server this was created

## if you opened another terminal tab
export VAULT_ADDR='http://127.0.0.1:8200'

## or you can sourse it perminently
echo "export VAULT_ADDR='http://127.0.0.1:8200'" >> ~/.bashrc
source ~/.bashrc

## set var for root vault token
export TF_VAR_vault_token='<vault_root_token>' ## you should see this where you started the vault serve and it is running

vault kv put secret/myapp/database \
mysql_username="Bob123" \
mysql_password="supersecret" 

## get secret for verification
vault kv get secret/myapp/database

tf init
tf plan
tf apply

## enabling
# Reload systemd
sudo systemctl daemon-reload

# Enable Vault to start on boot
sudo systemctl enable vault

# Start Vault
sudo systemctl start vault

# Check Vault status
sudo systemctl status vault

```