Day 69: Install Jenkins Plugins

>Two things define you: your patience when you have nothing and your attitude when you have everything.
>
>– George Bernard Shaw

>There is only one success - to be able to spend your life in your own way.
>
>– Christopher Morley

The Nautilus DevOps team has recently setup a Jenkins server, which they want to use for some CI/CD jobs. Before that they want to install some plugins which will be used in most of the jobs. Please find below more details about the task

**1.** Click on the `Jenkins` button on the top bar to access the Jenkins UI. Login using username `admin` and `Adm!n321` password.

**2.** Once logged in, install the `Git` and `GitLab` plugins. Note that you may need to `restart` Jenkins service to complete the plugins installation. If required, opt to Restart Jenkins when installation is complete and no jobs are running on plugin `installation/update` page (update centre).

> **Note:**
> 1. After restarting the Jenkins service, wait for the Jenkins login page to reappear before proceeding.
> 2. For tasks involving web UI changes, capture screenshots to share for review or consider using screen recording software like loom.com for documentation and sharing.

## Solution
```bash
# 1) Access the Jenkins UI
# Open your browser and go to: http://jenkins.stratos.xfusioncorp.com:8080
# Login with:
#   Username: admin
#   Password: Adm!n321

# 2) Install Git and GitLab plugins
# - Click "Manage Jenkins" in the left sidebar
# - Click "Manage Plugins"
# - Go to the "Available" tab
# - Search for "Git" and select "Git plugin"
# - Search for "GitLab" and select "GitLab plugin"
# - Click "Install without restart" (or "Download now and install after restart")

# 3) If prompted, restart Jenkins after installation
# - Click "Restart Jenkins when installation is complete and no jobs are running"
# - Wait for Jenkins to restart and the login page to reappear

# 4) (Optional) Capture screenshots of the plugin installation and restart process for documentation or review
```