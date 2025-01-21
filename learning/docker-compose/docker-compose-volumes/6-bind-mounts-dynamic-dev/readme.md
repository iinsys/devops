### Using Bind Mounts for Dynamic Development
- Bind mounts let you sync files between the host machine and the container, useful during local development.

**Scenario**
You want to run a Python application and edit the code locally while the container automatically picks up changes.

**How It Works**
- The `src` directory on the host is bind-mounted to `/usr/src/app` in the container.
- You can edit files in the `src` directory, and changes will immediately reflect in the container.