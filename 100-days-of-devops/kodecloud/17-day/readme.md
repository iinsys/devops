Day 17: Install and Configure PostgreSQL


>If you really look closely, most overnight successes took a long time.
>
>– Steve Jobs

The `Nautilus` application development team has shared that they are planning to deploy one newly developed application on Nautilus infra in `Stratos D`C. The application uses PostgreSQL database, so as a pre-requisite we need to set up PostgreSQL database server as per requirements shared below:



PostgreSQL database server is already installed on the Nautilus database server.


a. Create a database user `kodekloud_cap` and set its password to `YchZHRcLkL`.


b. Create a database `kodekloud_db5` and grant full permissions to user `kodekloud_cap` on this database.


`Note:` Please do not try to restart PostgreSQL server service.

## Solution
```bash
# 1. SSH into the DB server
ssh peter@stdb01.stratos.xfusioncorp.com
# password: Sp!dy

# 2. Switch to postgres system user
sudo su - postgres

# 3. Enter PostgreSQL shell
psql <<EOF
-- Create user with password
CREATE USER kodekloud_cap WITH PASSWORD 'YchZHRcLkL';

-- Create database
CREATE DATABASE kodekloud_db5;

-- Grant full privileges on DB to user
GRANT ALL PRIVILEGES ON DATABASE kodekloud_db5 TO kodekloud_cap;
EOF

# 4. (Optional) Verify by connecting as the new user
psql -U kodekloud_cap -d kodekloud_db5 -h localhost

```