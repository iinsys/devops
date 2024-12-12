The Nautilus DevOps team aims to containerize various applications following a recent meeting with the application development team. They intend to conduct testing with the following steps:

Install docker-ce and docker compose packages on App Server 2.

Initiate the docker service.

### Solution
#### Steps to Access and Configure App Server 2

#### 1. Log into the Jump Host
#### Use the credentials provided to log into the Jump Host:
```bash
ssh thor@jump_host.stratos.xfusioncorp.com
# Password: mjolnir123
```
#### 2. SSH into App Server 2 (stapp02)
#### From the Jump Host, access stapp02:
```bash
ssh steve@stapp02.stratos.xfusioncorp.com
#### Password: Am3ric@
```
## 3. Update and Install Docker CE on stapp02
#### Follow the steps outlined earlier for installing Docker CE:
```bash
sudo apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io
```
#### 4. Start and Enable Docker Service
```bash
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
```
### 5. Install Docker Compose
```bash
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version
```
#### 6. Test Docker Installation
```bash
sudo docker run hello-world
```
#### 7. Add User to Docker Group (Optional)
#### To avoid using sudo for Docker commands:
```bash
sudo usermod -aG docker steve
```
#### Log out and log back in for changes to take effect.

#### Verification
#### Ensure Docker and Docker Compose are properly installed and functional.

#### Check Docker version:
docker --version

## Check Docker Compose version:
```bash
docker-compose --version

## Run a test container:
docker run hello-world
```