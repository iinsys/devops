# Achieving Least Privilege in Docker

Ensuring containers run with only the permissions they truly need is one of the most effective defenses against compromise. The Docker documentation emphasises *least privilege* as a core security practice—limit what a container can do, lower the blast radius if it is exploited, and make abuse easier to detect.[^1] This guide walks through key controls Docker exposes, and finishes with a repeatable hands-on exercise you can run locally.

[^1]: Docker Docs — [Apply security best practices to Dockerfiles](https://docs.docker.com/build/building/best-practices/#security) and [Runtime privilege & Linux capabilities](https://docs.docker.com/engine/security/rootless/).

---

## 1. What “Least Privilege” Means for Containers

At its heart, least privilege is the idea that workloads only need:

- the minimum filesystem access required to operate
- a non-root identity, so the container cannot trivially take over the host
- only the Linux capabilities that map to the tasks it performs
- explicit resource limits to contain runaway processes

Docker exposes controls for every one of these dimensions through both the `Dockerfile` (build-time choices) and `docker run` flags (runtime policy).

---

## 2. Build-Time Controls (Dockerfile)

The official guidelines highlight three quick wins:[^1]

1. **Use a minimal base image** (e.g., `distroless` or Alpine) so the container inherits fewer default binaries and attack surface.
2. **Create and switch to a non-root user** with only the filesystem paths it needs.
3. **Scope file ownership and permissions** so write access is limited.

```Dockerfile
# Dockerfile
FROM python:3.12-slim

# Create a system user and group
RUN addgroup --system app && adduser --system --ingroup app app

# Copy application code and drop ownership to the app user
WORKDIR /opt/service
COPY --chown=app:app requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY --chown=app:app . .

# Run as the non-root user
USER app

CMD ["python", "app.py"]
```

Key points:

- The `USER` directive ensures all subsequent layers (and the running process) inherit the non-root identity.
- `--chown` on `COPY` prevents root-owned artefacts, which could otherwise allow privilege escalation if the runtime tried to write to those files.

---

## 3. Runtime Controls (`docker run`)

Even with a hardened image, Docker defaults to granting capabilities beyond what most applications need. Official docs recommend *dropping all capabilities by default*, then re-adding only the ones the workload relies on.[^2]

[^2]: Docker Docs — [Linux capabilities in practice](https://docs.docker.com/engine/security/capabilities/).

Here are the runtime flags we will use in the practical section:

| Flag | Why it matters |
|------|----------------|
| `--user` | Overrides the container’s user ID at runtime. Using the same non-root ID as the Dockerfile keeps both layers consistent. |
| `--cap-drop ALL` and `--cap-add` | Remove every capability, then add back a handful—for example `NET_BIND_SERVICE` for binding to privileged ports. |
| `--read-only` | Mount the container filesystem as read-only; pair with writable volumes for state that must persist. |
| `--tmpfs` | Provide ephemeral writable space (e.g., `/tmp`) without broad write access elsewhere. |
| `--security-opt no-new-privileges` | Blocks setuid binaries and other mechanisms from elevating privilege inside the container. |
| `--memory`, `--cpus`, `--pids-limit` | Resource governance—if the process is compromised it cannot starve the host. |

---

## 4. Hands-On: Locking Down a Simple Web Service

The following example runs a tiny Flask service with progressively tighter permissions. You can adapt it to your own applications by swapping out the base image and command.

### 4.1 Prepare the demo

```bash
cat <<'EOF' > app.py
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Least privilege demo!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF

cat <<'EOF' > requirements.txt
flask==3.0.2
EOF

cat <<'EOF' > Dockerfile
FROM python:3.12-slim

RUN addgroup --system app && adduser --system --ingroup app app
WORKDIR /opt/service
COPY --chown=app:app requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY --chown=app:app app.py .

USER app
CMD ["python", "app.py"]
EOF

docker build -t least-privilege-demo:latest .
```

### 4.2 Run with default privileges (baseline)

```bash
docker run --rm -p 5000:5000 least-privilege-demo:latest
```

This works, but the container still has many capabilities and a writable root filesystem.

### 4.3 Re-run with least privilege

```bash
docker run --rm -d \
  --name least-priv \
  --user app \
  --read-only \
  --tmpfs /tmp \
  --cap-drop ALL \
  --cap-add NET_BIND_SERVICE \
  --security-opt no-new-privileges \
  --memory 256m \
  --cpus 0.5 \
  least-privilege-demo:latest
```

**What changed:**

- The filesystem is now read-only, except for the `tmpfs` mount at `/tmp`.
- Capabilities are stripped down to one—the app can bind to port 5000 (above 1024), so technically it would work even without `NET_BIND_SERVICE`, but this illustrates how to add back the minimum set.
- `no-new-privileges` ensures setuid binaries cannot escalate.
- Resource limits prevent denial-of-service side effects.

Verify the container is healthy:

```bash
curl http://localhost:5000
docker exec least-priv id
docker exec least-priv cat /proc/self/status | grep CapEff
docker exec least-priv touch /tmp/test-file && docker exec least-priv ls -l /tmp/test-file
```

Expected output:

```text
$ curl http://localhost:5000
Least privilege demo!

$ docker exec least-priv id
uid=100(app) gid=101(app) groups=101(app)

$ docker exec least-priv cat /proc/self/status | grep CapEff
CapEff:	0000000000000000

$ docker exec least-priv ls -l /tmp/test-file
-rw-r--r-- 1 app app 0 Nov  8 08:04 /tmp/test-file
```

The zeroed-out `CapEff` confirms all capabilities are dropped. Trying to write anywhere other than `/tmp` should fail:

```bash
docker exec least-priv touch /opt/service/newfile
# touch: cannot touch '/opt/service/newfile': Read-only file system
```

### 4.4 Clean up

```bash
docker rm -f least-priv
rm -f Dockerfile app.py requirements.txt
```

---

## 5. Additional Hardening Ideas

- **Rootless Docker:** Run the Docker daemon itself without root privileges.[^3]
- **Dedicated AppArmor/SELinux Profiles:** Limit system calls and file access even further.
- **Read-only Secrets:** Mount configuration through Docker secrets or Kubernetes ConfigMaps and avoid baking secrets into images.
- **Supply chain controls:** Pin base image digests and verify them before promotion.

[^3]: Docker Docs — [Run the Docker daemon as a non-root user (Rootless mode)](https://docs.docker.com/engine/security/rootless/).

---

## 6. Key Takeaways

- Least privilege is a principle; Docker gives you the tooling to apply it.
- Small, non-root images eliminate entire classes of privilege escalation.
- Runtime flags let you defend in depth—capabilities, filesystem access, resource limits.
- The pattern mirrors Kubernetes security contexts, so what you practice locally carries over to orchestrated environments.

With these habits, containers remain focused on the work they should do—and little else.

