Day 43: Docker Ports Mapping

>Focus on the outcome not the obstacle.
>
>– Unknown

The Nautilus DevOps team is planning to host an application on a nginx-based container. There are number of tickets already been created for similar tasks. One of the tickets has been assigned to set up a nginx container on `Application Server 2` in Stratos Datacenter. Please perform the task as per details mentioned below:


a. Pull `nginx:alpine-perl` docker image on `Application Server 2`.


b. Create a container named `blog` using the image you pulled.


c. Map host port `3004` to container port `80`. Please keep the container in `running` state.

## Solution
```bash
# --- Step 2: SSH into App Server 2 ---
ssh steve@stapp02.stratos.xfusioncorp.com
# password: Am3ric@

# --- Step 3: Pull nginx:alpine-perl image ---
sudo docker pull nginx:alpine-perl

# --- Step 4: Run container named blog mapping host port 3004 -> container port 80 ---
sudo docker run -d --name blog -p 3004:80 nginx:alpine-perl

# --- Step 5: Verify container is running ---
sudo docker ps | grep blog

```




