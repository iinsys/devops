### Volume for Logs
Store application logs in a volume for debugging and analysis.

**Scenario**
You want to persist logs from a Node.js application.

**How It Works**
- Logs generated in the container are stored in the logs directory on your host machine.
**Check Logs**
After the container starts, check the `logs/app.log `file on your local machine.