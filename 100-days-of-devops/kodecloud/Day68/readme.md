Day 68: Set Up Jenkins Server

>Those who hoard gold have riches for a moment.
>Those who hoard knowledge and skills have riches for a lifetime.
>
>– The Diary of a CEO

---
>You are never too old to set another goal or to dream a new dream.
>
>– Malala Yousafzai
---
>You don’t understand anything until you learn it more than one way.
>
>– Marvin Minsky
---
>One day or day one. It's your choice.

The DevOps team at xFusionCorp Industries is initiating the setup of CI/CD pipelines and has decided to utilize Jenkins as their server. Execute the task according to the provided requirements:



1. Install `Jenkins` on the jenkins server using the yum utility only, and start its service.

If you face a timeout issue while starting the Jenkins service, refer to [this](https://www.jenkins.io/doc/book/system-administration/systemd-services/#starting-services).

2. Jenkin's admin user name should be `theadmin`, password should be `Adm!n321`, full name should be Yousuf and email should be `yousuf@jenkins.stratos.xfusioncorp.com`.


`Note:`

1. To access the jenkins server, connect from the jump host using the root user with the password `S3curePass`.

2. After Jenkins server installation, click the Jenkins button on the top bar to access the `Jenkins UI` and follow on-screen instructions to create an admin user.

## Solution

### Step 1: Connect to Jenkins Server
```bash
ssh root@jenkins.stratos.xfusioncorp.com
# password: S3curePass

# Make it executable
chmod +x install.sh

# Run the installation script
./install.sh
```
### Step 3: Access Jenkins UI
1. Open browser and navigate to: `http://jenkins.stratos.xfusioncorp.com:8080`
2. Enter the initial admin password (displayed by the install script)
3. Create admin user with the specified credentials:
   - **Username:** `theadmin`
   - **Password:** `Adm!n321`
   - **Full name:** `Yousuf`
   - **Email:** `yousuf@jenkins.stratos.xfusioncorp.com`
4. Complete the setup wizard


