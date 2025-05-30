```bash
# 1. Download the latest Ngrok .deb package
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | \
  sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null

echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | \
  sudo tee /etc/apt/sources.list.d/ngrok.list

# 2. Update your apt sources
sudo apt update

# 3. Install Ngrok
sudo apt install ngrok
```
### 🔑 Authenticate Ngrok with Your Account
After installing, connect your account using your Ngrok authtoken (found in your dashboard at https://dashboard.ngrok.com/get-started/setup):
```bash
ngrok config add-authtoken YOUR_NGROK_AUTHTOKEN
```
Replace YOUR_NGROK_AUTHTOKEN with the token from your dashboard.
```bash
ngrok version
snap install ngrok
```