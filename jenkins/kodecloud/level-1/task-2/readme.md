The Nautilus DevOps team has recently setup a Jenkins server, which they want to use for some CI/CD jobs. Before that they want to install some plugins which will be used in most of the jobs. Please find below more details about the task

- 1. Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username admin and Adm!n321 password.

- 2. Once logged in, install the `Git` and `GitLab` plugins. Note that you may need to restart Jenkins service to complete the plugins installation, If required, opt to `Restart Jenkins when installation is complete and no jobs are running` on plugin installation/update page i.e `update centre`.

`Note:`

- 1. After restarting the Jenkins service, wait for the Jenkins login page to reappear before proceeding.

- 2. For tasks involving web UI changes, capture screenshots to share for review or consider using screen recording software like loom.com for documentation and sharing.

### Solution
```bash
# login into the ui
# go to managed plugins 
# got to plugins
# select available plugins and search Git Plugin then check the box and install
# do same for Gitlab plugin
# Restart Jenkins when installation is complete
```