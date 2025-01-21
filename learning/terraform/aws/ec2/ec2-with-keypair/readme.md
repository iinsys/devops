chmod 400 nb-key-pair.pem
ssh -i nb-key-pair.pem ubuntu@<public_ip>
sudo apt update 
sudo apt install -y git