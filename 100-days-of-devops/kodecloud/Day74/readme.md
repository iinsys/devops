Day 74: Jenkins Database Backup Job

>You never know what you can do until you try.
>
>– William Cobbett

There is a requirement to create a Jenkins job to automate the database backup. Below you can find more details to accomplish this task:

**1.** Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username `admin` and password `Adm!n321`.

**2.** Create a Jenkins job named `database-backup`.

**3.** Configure it to take a database dump of the `kodekloud_db01` database present on the Database server in Stratos Datacenter:
   - Database user: `kodekloud_roy`
   - Password: `asdfgdsd`
   - Dump format: `db_$(date +%F).sql`

**4.** Copy the `db_$(date +%F).sql` dump to the Backup Server under location `/home/clint/db_backups`.

**5.** Schedule this job to run periodically at `*/10 * * * *`.

> **Note:**
> 1. You might need to install some plugins and restart Jenkins service. So, we recommend clicking on Restart Jenkins when installation is complete and no jobs are running on plugin installation/update page i.e update centre. Also, Jenkins UI sometimes gets stuck when Jenkins service restarts in the back end. In this case please make sure to refresh the UI page.
> 2. Please make sure to define your cron expression like this `*/10 * * * *` (this is just an example to run job every 10 minutes).
> 3. For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as loom.com to record and share your work.



## Solution
[Video ref](https://www.youtube.com/watch?v=wjKUyZe8a-4&t=609s)