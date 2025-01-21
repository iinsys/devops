###  Mounting Initialization Scripts
This example mounts a directory containing SQL scripts that are executed when a database starts.

**Scenario**
You want to initialize a PostgreSQL database with tables and data.

**How It Works**
- Place `.sql` or `.sh` scripts in the `init-scripts` directory.
- These scripts are automatically executed during container startup.
