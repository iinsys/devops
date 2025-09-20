Day 40: Docker EXEC Operations

>Study hard what interests you the most in the most undisciplined, irreverent and original manner possible.
>
>– Richard P. Feynman

One of the Nautilus DevOps team members was working to configure services on a `kkloud` container that is running on `App Server 2` in `Stratos Datacenter`. Due to some personal work he is on PTO for the rest of the week, but we need to finish his pending work ASAP. Please complete the remaining work as per details given below:


a. Install `apache2` in `kkloud` container using apt that is running on `App Server 2` in Stratos Datacenter.


b. Configure Apache to listen on port `6300` instead of default `http port`. Do not bind it to listen on specific IP or hostname only, i.e it should listen on localhost, `127.0.0.1`, container ip, etc.


c. Make sure `Apache service` is up and `running` inside the container. Keep the container in running state at the end.

## Solution
```bash
# --- Step 2: SSH into App Server 2 ---
ssh steve@stapp02.stratos.xfusioncorp.com
# password: Am3ric@

# --- Step 3: Verify the container is running ---
sudo docker ps | grep kkloud

# --- Step 4: Access the container shell ---
sudo docker exec -it kkloud bash

# --- Step 5: Inside container: Update packages and install apache2 ---
apt-get update -y
apt-get install apache2 -y

# --- Step 6: Change Apache to listen on port 6300 ---
sed -i 's/80/6300/g' /etc/apache2/ports.conf
sed -i 's/:80/:6300/g' /etc/apache2/sites-available/000-default.conf

# --- Step 7: Start Apache service ---
service apache2 start

# --- Step 8: Verify Apache is running on port 6300 ---

# Install net-tools so we can use netstat
apt-get install net-tools -y

netstat -tulnp | grep 6300
## or you can do this 
curl http://localhost:6300

# --- Step 9: Exit container ---
exit

# --- Step 10: Confirm container is still running ---
sudo docker ps | grep kkloud

```