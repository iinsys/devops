Day 57: Print Environment Variables

>Neither comprehension nor learning can take place in an atmosphere of anxiety.
>
>– Rose Kennedy

The Nautilus DevOps team is working on to setup some pre-requisites for an application that will send the greetings to different users. There is a sample deployment, that needs to be tested. Below is a scenario which needs to be configured on Kubernetes cluster. Please find below more details about it.


   1. Create a `pod` named `print-envars-greeting`.

   2. Configure `spec` as, the container name should be `print-env-container` and use `bash image`.

   3. Create `three environment` variables:

a. `GREETING` and its value should be `Welcome to`

b. `COMPANY` and its value should be `Nautilus`

c. `GROUP` and its value should be `Industries`

Use command `["/bin/sh", "-c", 'echo "$(GREETING) $(COMPANY) $(GROUP)"']` (please use this exact command), also set its `restartPolicy` policy to `Never` to avoid crash loop back.

You can check the output using `kubectl logs -f print-envars-greeting` command.


`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# 1) Create the pod manifest
cat <<'EOF' > print-envars-greeting.yaml
apiVersion: v1
kind: Pod
metadata:
  name: print-envars-greeting
spec:
  restartPolicy: Never
  containers:
    - name: print-env-container
      image: bash:latest
      env:
        - name: GREETING
          value: "Welcome to"
        - name: COMPANY
          value: "Nautilus"
        - name: GROUP
          value: "Industries"
      command: ["/bin/sh", "-c", 'echo "$(GREETING) $(COMPANY) $(GROUP)"']
EOF

# 2) Apply the manifest
kubectl apply -f print-envars-greeting.yaml

# 3) Check pod status
kubectl get pods print-envars-greeting

# 4) View output logs
kubectl logs -f print-envars-greeting

```