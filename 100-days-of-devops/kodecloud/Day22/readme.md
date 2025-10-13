Day 22: Clone Git Repository on Storage Server

>Great things never came from comfort zones.
>
>– Tony Luziaya

>Practice as if you are the worst, Perform as if you are the best.

The DevOps team established a new Git repository last week, which remains unused at present. However, the Nautilus application development team now requires a copy of this repository on the Storage Server in the Stratos DC. Follow the provided details to clone the repository:



- The repository to be cloned is located at `/opt/ecommerce.git`


- Clone this Git repository to the `/usr/src/kodekloudrepos` directory. Ensure no modifications are made to the repository during the cloning process.
## Solution
```bash
## Day 22 DevOps Task – Clone Git Repository on Storage Server

### Step 1: SSH into Storage Server
ssh natasha@ststor01.stratos.xfusioncorp.com
# password: Bl@kW

### Step 2: Clone the Git repository as a mirror
cd /usr/src/kodekloudrepos
sudo git clone --mirror /opt/games.git

### Note:
- The warning "cloned an empty repository" means the source repo `/opt/ecommerce.git` has no commits yet.
- Verify repo content with:
  sudo git --git-dir=/opt/ecommerce.git log

### Step 3: Verify cloned repo files
sudo ls -l /usr/src/kodekloudrepos


```
