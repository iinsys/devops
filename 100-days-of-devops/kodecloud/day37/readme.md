Day 37: Copy File to Docker Container

>I am experienced enough to do this. I am knowledgeable enough to do this. I am prepared enough to do this. I am mature enough to do this. I am brave enough to do this.
>
>– Alexandria Ocasio-Cortez

The Nautilus DevOps team possesses confidential data on `App Server 1 `in the Stratos Datacenter. A container named `ubuntu_latest` is running on the same server.



Copy an encrypted file `/tmp/nautilus.txt.gpg` from the docker host to the `ubuntu_latest` container located at `/usr/src/`. Ensure the file is not modified during this operation.

## Solution
```bash
# --- Step 2: SSH into App Server 1 (stapp01) ---
ssh tony@stapp01.stratos.xfusioncorp.com
# password: Ir0nM@n

# --- Step 3: Verify the container is running ---
sudo docker ps

# You should see the container named `ubuntu_latest`

# --- Step 4: Copy the encrypted file into the container ---
sudo docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/usr/src/

# --- Step 5: Verify inside the container ---
sudo docker exec -it ubuntu_latest ls -l /usr/src/
```