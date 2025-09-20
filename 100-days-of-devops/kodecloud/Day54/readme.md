Day 54: Kubernetes Shared Volumes

>The best way to guarantee a loss is to quit.
>
>– Morgan Freeman

We are working on an application that will be deployed on multiple containers within a pod on Kubernetes cluster. There is a requirement to share a volume among the containers to save some temporary data. The Nautilus DevOps team is developing a similar template to replicate the scenario. Below you can find more details about it.



1. Create a pod named `volume-share-devops`.


2. For the first container, use image `fedora` with `latest` tag only and remember to mention the tag i.e `fedora:latest`, container should be named as `volume-container-devops-1`, and run a `sleep` command for it so that it remains in running state. Volume `volume-share` should be mounted at path `/tmp/ecommerce`.


3. For the second container, use image fedora with the latest tag only and remember to mention the tag i.e `fedora:latest`, container should be named as `volume-container-devops-2`, and again run a `slee`p command for it so that it remains in running state. Volume `volume-share` should be mounted at path `/tmp/games`.


4. Volume name should be `volume-share` of type `emptyDir`.


5. After creating the pod, exec into the first container i.e `volume-container-devops-1`, and just for testing create a file `ecommerce.txt` with any content under the mounted path of first container i.e `/tmp/ecommerce`.


6. The file `ecommerce.txt` should be present under the mounted path `/tmp/games` on the second container `volume-container-devops-2` as well, since they are using a shared volume.


`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution
```bash
# 1. Create the pod definition YAML
cat <<EOF > volume-share-devops.yaml
apiVersion: v1
kind: Pod
metadata:
  name: volume-share-devops
spec:
  volumes:
  - name: volume-share
    emptyDir: {}
  containers:
  - name: volume-container-devops-1
    image: fedora:latest
    command: ["sleep", "3600"]
    volumeMounts:
    - name: volume-share
      mountPath: /tmp/ecommerce
  - name: volume-container-devops-2
    image: fedora:latest
    command: ["sleep", "3600"]
    volumeMounts:
    - name: volume-share
      mountPath: /tmp/games
EOF

# 2. Apply the pod
kubectl apply -f volume-share-devops.yaml

# 3. Exec into the first container and create a test file
kubectl exec -it volume-share-devops -c volume-container-devops-1 -- \
  sh -c "echo 'shared data test' > /tmp/ecommerce/ecommerce.txt"

# 4. Verify the file from the second container
kubectl exec -it volume-share-devops -c volume-container-devops-2 -- \
  cat /tmp/games/ecommerce.txt

# 5 verify that pod is running 
kubectl get pods -owide

```