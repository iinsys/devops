Day 72: Jenkins Parameterized Builds

>I can and I will. Watch me.
>
>– Carrie Green

A new DevOps Engineer has joined the team and he will be assigned some Jenkins related tasks. Before that, the team wanted to test a simple parameterized job to understand basic functionality of parameterized builds. He is given a simple parameterized job to build in Jenkins. Please find more details below:

**1.** Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username `admin` and password `Adm!n321`.

**2.** Create a parameterized job which should be named as `parameterized-job`.

**3.** Add a string parameter named `Stage`; its default value should be `Build`.

**4.** Add a choice parameter named `env`; its choices should be `Development`, `Staging` and `Production`.

**5.** Configure job to execute a shell command, which should echo both parameter values (you are passing in the job).

**6.** Build the Jenkins job at least once with choice parameter value `Production` to make sure it passes.

> **Note:**
> 1. You might need to install some plugins and restart Jenkins service. So, we recommend clicking on Restart Jenkins when installation is complete and no jobs are running on plugin installation/update page i.e update centre. Also, Jenkins UI sometimes gets stuck when Jenkins service restarts in the back end. In this case, please make sure to refresh the UI page.
> 2. For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as loom.com to record and share your work.

## Solution
```bash
# 1) Access the Jenkins UI
# Open your browser and go to: http://jenkins.stratos.xfusioncorp.com:8080
# Login with:
#   Username: admin
#   Password: Adm!n321

# 2) Create a new job
# - Click "New Item"
# - Enter the name: parameterized-job
# - Select "Freestyle project" and click OK

# 3) Add parameters
# - Check "This project is parameterized"
# - Add "String Parameter":
#     Name: Stage
#     Default Value: Build
# - Add "Choice Parameter":
#     Name: env
#     Choices: Development, Staging, Production (one per line)

# 4) Configure build step
# - Add a "Build" step: "Execute shell"
# - Command:
#     echo "Stage: $Stage"
#     echo "Environment: $env"

# 5) Save the job

# 6) Build the job
# - Click "Build with Parameters"
# - Set env to "Production" and build
# - Confirm the build passes and the console output shows the correct parameter values


```
[Check ref video](https://www.youtube.com/watch?v=gZW1hvss9_4)