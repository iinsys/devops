# Wazuh Config Layer

This chart demonstrates how to keep the vendor-supplied configuration file that ships inside the Wazuh agent container image (`/var/ossec/etc/ossec.conf`) and append your own organisation-specific overrides without replacing the original file.

The flow mirrors real-world platforms where the application image already contains its baseline configuration. Helm provides the snippet of overrides, while an init container copies the original file to a scratch volume, appends the snippet, and exposes the merged file to the running container as a projected file.

## What Gets Deployed

- A single Wazuh agent pod (default command is `sleep infinity` so the container stays alive for inspection).
- An init container that copies `/var/ossec/etc/ossec.conf` out of the image, appends the overrides from a ConfigMap key, and places the merged file in an `emptyDir`.
- The main container mounts only the merged file via `subPath`, so the rest of `/var/ossec/etc` remains untouched.

## Customising Overrides

Override snippets are provided through the `config.extra` value. The defaults in `values.yaml` illustrate pointing the agent at a custom manager address:

```yaml
config:
  mountPath: /var/ossec/etc
  existingFilePath: /var/ossec/etc/ossec.conf
  fileName: ossec.conf
  snippetFileName: ossec-overrides.conf
  extra: |
    <client>
      <server>
        <address>wazuh-manager.example.svc</address>
      </server>
    </client>
```

You can keep team or environment-specific overrides in manifest files (for example, `values-prod.yaml`) and supply them with `-f` so changes are tracked in source control.

## Deploying to Minikube

```bash
cd devops/devops/learning/helm

helm install wazuh-layer ./wazuh-config-layer
```

If the release already exists and you simply want to pull in the latest chart defaults, run:

```bash
helm upgrade wazuh-layer ./wazuh-config-layer
```

After Helm finishes, confirm the file merge:

```bash
kubectl exec deploy/wazuh-layer-wazuh-config-layer -- cat /var/ossec/etc/ossec.conf
```

You should see the vendor defaults followed by the custom snippet appended near the bottom with the comment `<!-- Custom overrides appended by Helm -->`.

Example (truncated) output:

```text
...
<!-- Custom overrides appended by Helm -->

<!-- Example override -->
<client>
  <server>
    <address>wazuh-manager.example.svc</address>
  </server>
</client>
```

## Updating Overrides

Keep override snippets in versioned manifests so you can roll back or promote them between environments. For example, `values-prod.yaml` might contain:

```yaml
config:
  extra: |
    <client>
      <server>
        <address>wazuh-manager.prod.svc</address>
      </server>
      <crypto_method>aes</crypto_method>
    </client>
```

Apply the changes with Helm (this handles both first-time installs and later updates):

```bash
helm upgrade --install wazuh-layer ./wazuh-config-layer -f values-prod.yaml
```

Helm updates the ConfigMap, the init container re-runs, and the merged file is rebuilt with your new snippet while the vendor defaults remain at the top of `ossec.conf`.

To force an immediate refresh based on the latest values (without waiting for a reconciliation event), restart the deployment and re-check the file:

```bash
kubectl rollout restart deploy/wazuh-layer-wazuh-config-layer
kubectl rollout status deploy/wazuh-layer-wazuh-config-layer
kubectl exec deploy/wazuh-layer-wazuh-config-layer -- cat /var/ossec/etc/ossec.conf
```

## How the Configuration Layering Works

- **ConfigMap**: Helm renders your overrides into a ConfigMap key (`ossec-overrides.conf`).
- **Init container**: The pod includes an init container that runs before the main Wazuh agent. It copies the vendor-provided `/var/ossec/etc/ossec.conf` out of the image into an `emptyDir`, appends the ConfigMap snippet, and exits.
- **`emptyDir` volume**: Acts as scratch space shared between the init container and the main container. It holds the merged `ossec.conf`.
- **Volume mount with `subPath`**: The main container mounts only the merged file (not the entire directory) back to `/var/ossec/etc/ossec.conf`, so the rest of the vendor configuration stays untouched.

This combination lets us append configuration safely without relying on Secrets or replacing the upstream file.

### Handling Permission Constraints

Because the chart copies the vendor file into an `emptyDir`, it only needs read access to the original path. If the init container lacks permission to read from `config.existingFilePath`, configure the security context values exposed in `values.yaml`. For example, to run the init container as root and grant the main container read access:

```yaml
initContainerSecurityContext:
  runAsUser: 0
  runAsGroup: 0

containerSecurityContext:
  runAsUser: 1000
  fsGroup: 1000
```

Apply the manifest with `helm upgrade --install ... -f <your-values>.yaml`, then restart the deployment to rebuild the merged file as shown above.

## Cleanup

```bash
helm uninstall wazuh-layer
```

