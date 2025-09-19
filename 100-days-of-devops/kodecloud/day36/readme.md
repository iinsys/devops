Day 36: Deploy Nginx Container on Application Server


>Regret for the time wasted can become a power of good in the time that remains.
>
>– Arthur Brisbane

The Nautilus DevOps team is conducting application deployment tests on selected application servers. They require a nginx container deployment on `Application Server 1`. Complete the task with the following instructions:


On `Application Server 1` create a `container` named `nginx_1` using the `nginx` image with the alpine tag. Ensure container is in a `running` state.

## Solution
```bash
# --- Step 2: SSH into App Server 1 (stapp01) ---
ssh tony@stapp01.stratos.xfusioncorp.com
# password: Ir0nM@n

# --- Step 3: Pull nginx:alpine image ---
sudo docker pull nginx:alpine

# --- Step 4: Run container named nginx_1 from nginx:alpine ---
sudo docker run -d --name nginx_1 nginx:alpine

# --- Step 5: Verify container is running ---
sudo docker ps -a

# (Optional) test container by exec into it
# sudo docker exec -it nginx_1 sh

```