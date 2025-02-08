#!/bin/bash

# Define app servers
APP_SERVERS=("stapp01" "stapp02" "stapp03")

# Credentials (update if needed)
USERNAMES=("tony" "steve" "banner")
PASSWORDS=("Ir0nM@n" "Am3ric@" "BigGr33n")

# SSH Options to avoid host key confirmation
SSH_OPTS="-o StrictHostKeyChecking=no"

# Loop through each server
for i in "${!APP_SERVERS[@]}"; do
    SERVER="${APP_SERVERS[$i]}.stratos.xfusioncorp.com"
    USER="${USERNAMES[$i]}"
    PASS="${PASSWORDS[$i]}"

    echo "Connecting to $SERVER as $USER..."
    
    # Use SSH and sudo to execute commands remotely
    sshpass -p "$PASS" ssh $SSH_OPTS "$USER@$SERVER" <<EOF
        echo "Creating user kareem..."
        sudo useradd -m -s /bin/bash kareem 2>/dev/null || echo "User already exists."

        echo "Setting up password-less sudo..."
        echo "kareem ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/kareem

        echo "Validating sudo access..."
        sudo -l -U kareem
EOF

    echo "Done on $SERVER ✅"
    echo "-------------------------------------"
done

echo "✅ Sudo access granted to kareem on all app servers!"
