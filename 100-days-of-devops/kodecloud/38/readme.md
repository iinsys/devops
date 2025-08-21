Day 38: Pull Docker Image

>Neither comprehension nor learning can take place in an atmosphere of anxiety.
>
>– Rose Kennedy

Nautilus project developers are planning to start testing on a new project. As per their meeting with the DevOps team, they want to test containerized environment application features. As per details shared with DevOps team, we need to accomplish the following task:


a. Pull `busybox:musl` image on `App Server `1 in `Stratos DC` and `re-tag` (create new tag) this image as `busybox:news`.

## Solution
```bash
# --- Step 2: SSH into App Server 1 (stapp01) ---
ssh tony@stapp01.stratos.xfusioncorp.com
# password: Ir0nM@n

# --- Step 3: Pull busybox:musl image ---
sudo docker pull busybox:musl

# --- Step 4: Re-tag the image as busybox:news ---
sudo docker tag busybox:musl busybox:news

# --- Step 5: Verify both tags exist ---
sudo docker images | grep busybox

# Expected output should show both:
# busybox   musl   <IMAGE_ID>   ...
# busybox   news   <IMAGE_ID>   ...

```