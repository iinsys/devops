### Using Multiple Volumes
You can mount multiple volumes for different purposes.

**Scenario**
Your application needs:

- Persistent database storage.
- Logs stored separately.
- Custom configuration files

**How It Works**
- `app-data`is a named volume for persistent application data.
- `./config` contains configuration files.
- `./logs` stores logs.