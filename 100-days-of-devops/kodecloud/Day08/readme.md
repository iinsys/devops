Day 8: Install Ansible 4.10.0 on the Jump Host using pip3

>The beautiful thing about learning is that nobody can take it away from you.

During the weekly meeting, the Nautilus DevOps team discussed automation and configuration management tools. They decided to use **Ansible** due to its simple setup and minimal prerequisites. For initial testing, the **Jump Host** will be used as the Ansible control node.

Install **Ansible v4.10.0** using **pip3** on the **Jump Host**, and make sure it's available **globally** (all users can run it).

## Infrastructure Overview  

| Server       | Hostname                         | User | Purpose              |
|--------------|----------------------------------|------|----------------------|
| Jump Host    | jump_host.stratos.xfusioncorp.com | thor | Ansible Controller   |

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# ========= [ 1. SSH into the Jump Host as thor ] =========
ssh thor@jump_host
# Password: mjolnir123

# ========= [ 2. Install pip3 (if not installed) ] =========
sudo yum install -y python3-pip

# ========= [ 3. Upgrade pip and setuptools ] =========
sudo pip3 install --upgrade pip setuptools

# ========= [ 4. Install Ansible 4.10.0  ] =========
# Find where pip3 is installed
which pip3

# Use full path to run as root
sudo /usr/local/bin/pip3 install ansible==4.10.0

# ========= [ 5. Verify Ansible installation ] =========
ansible --version

# Output should include:
# ansible [core 2.11.12] 
#   config file = None
#   configured module search path = ['/home/thor/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
#   ansible python module location = /usr/local/lib/python3.9/site-packages/ansible
#   ansible collection location = /home/thor/.ansible/collections:/usr/share/ansible/collections
#   executable location = /usr/local/bin/ansible
#   python version = 3.9.18 (main, Jan 24 2024, 00:00:00) [GCC 11.4.1 20231218 (Red Hat 11.4.1-3)]
#   jinja version = 3.1.6
#   libyaml = True
```