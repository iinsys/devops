Day 47: Docker Python App

>You don’t understand anything until you learn it more than one way.
>
>– Marvin Minsky

A python app needed to be `Dockerized`, and then it needs to be deployed on `App Server 1`. We have already copied a `requirements.txt` file (having the app dependencies) under `/python_app/src/ directory` on `App Server 1`. Further complete this task as per details mentioned below:



1. Create a Dockerfile under `/python_app` directory:

  - Use any python image as the base image.
  - Install the dependencies using `requirements.txt` file.
  - Expose the port `5004`.
  - Run the `server.py` script using `CMD`.

2. Build an image named `nautilus/python-app` using this `Dockerfile`.


3. Once image is built, create a container named `pythonapp_nautilus`:

  - Map port `5004` of the container to the host port `8095`.

4. Once deployed, you can test the app using curl command on `App Server `1.

```bash
curl http://localhost:8095/
```

## Solution
```bash
# 1. SSH into App Server 1
ssh tony@stapp01.stratos.xfusioncorp.com
# password: Ir0nM@n

# 2. Navigate to the python_app directory
cd /python_app

# 3. Create Dockerfile
sudo tee Dockerfile > /dev/null <<'EOF'
# Use Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements.txt
COPY src/requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy all app files
COPY src/ .

# Expose port
EXPOSE 5004

# Run the app
CMD ["python", "server.py"]
EOF

# 4. Build the image
sudo docker build -t nautilus/python-app .

# 5. Run a container from the image
sudo docker run -d \
  --name pythonapp_nautilus \
  -p 8095:5004 \
  nautilus/python-app

# 6. Verify container is running
sudo docker ps

# 7. Test the app
curl http://localhost:8095/

```