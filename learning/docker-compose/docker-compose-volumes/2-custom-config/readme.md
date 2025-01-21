Mounting Custom Configuration Files
This example mounts a custom configuration file into a container.

**Scenario**
You want to provide a custom `postgresql.conf` file to PostgreSQL.

**How It Works**
- The `custom-postgresql.conf` file in your project directory is mounted to `/etc/postgresql/postgresql.conf` inside the container.
- PostgreSQL uses this custom configuration when starting up.
