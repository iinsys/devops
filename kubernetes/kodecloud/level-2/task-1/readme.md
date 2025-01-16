We are working on an application that will be deployed on multiple containers within a pod on Kubernetes cluster. There is a requirement to share a volume among the containers to save some temporary data. The Nautilus DevOps team is developing a similar template to replicate the scenario. Below you can find more details about it.


- Create a pod named volume-share-datacenter.

- For the first container, use image `debian` with `latest` tag only and remember to mention the tag i.e `debian:latest`, container should be named as `volume-container-datacenter-1`, and run a `sleep` command for it so that it remains in running state. Volume `volume-share` should be mounted at path `/tmp/beta`.

- For the second container, use image `debian` with the `latest` tag only and remember to mention the tag i.e `debian:latest`, container should be named as `volume-container-datacenter-2`, and again run a `sleep` command for it so that it remains in running state. Volume `volume-share` should be mounted at path `/tmp/games`.

- Volume name should be `volume-share` of type `emptyDir`.

- After creating the pod, exec into the first container i.e `volume-container-datacenter-1`, and just for testing create a file `beta.txt` with any content under the mounted path of first container i.e `/tmp/beta`.

- The file `beta.txt` should be present under the mounted path `/tmp/games` on the second container `volume-container-datacenter-2` as well, since they are using a shared volume.

`Note:` The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

## Solution
```bash
## apply file
kubectl apply -f volume-share-datacenter-pod.yaml
## verify pod status
kubectl get pods

## test shared volume
kubectl exec -it volume-share-datacenter -c volume-container-datacenter-1 -- bash
echo "This is a test file" > /tmp/beta/beta.txt
exit

## Now, verify the file is accessible in the second container:
kubectl exec -it volume-share-datacenter -c volume-container-datacenter-2 -- bash
cat /tmp/games/beta.txt
## you should see beta.txt in the second container

## cleanup
kubectl delete pod volume-share-datacenter
```