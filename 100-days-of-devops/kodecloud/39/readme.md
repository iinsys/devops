Day 39: Create a Docker Image From Container

>The way to get started is to quit talking and begin doing.
>
>– Walt Disney

One of the Nautilus developer was working to test new changes on a container. He wants to keep a backup of his changes to the container. A new request has been raised for the DevOps team to create a new image from this container. Below are more details about it:


a. Create an image `media:xfusion` on `Application Server 1` from a container `ubuntu_latest` that is `running` on same server.

## Solution
```bash
# --- Step 2: SSH into App Server 1 ---
ssh tony@stapp01.stratos.xfusioncorp.com
# password: Ir0nM@n

# --- Step 3: Check that the container ubuntu_latest is running ---
sudo docker ps | grep ubuntu_latest

# --- Step 4: Commit the running container to a new image ---
# Syntax: docker commit <container_name_or_id> <new_image_name>:<tag>
sudo docker commit ubuntu_latest media:xfusion

# --- Step 5: Verify that the new image was created ---
sudo docker images | grep media

# Expected output:
# media   xfusion   <IMAGE_ID>   ...

```




