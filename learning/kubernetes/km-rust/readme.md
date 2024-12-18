[Link to article of project](https://blog.kubesimplify.com/kubernetes-management-with-rust-a-dive-into-generic-client-go-controller-abstractions-and-crd-macros-with-kubers#heading-step-1-initialize-the-project)

```bash
rustup update
rustc --version

#project 1
#List all pods on cluster
##run to test
cargo run -- --kubers-demo kubectl -- get po

##project 2
#Create custom resource definition schema
cargo run
## verify cdr creation
kubectl get crd


##apply crd yaml
kubectl apply -f kcdhyd.yaml

##Print a specific jsonpath of CRD
kubectl get kcdtrack2 integrating-rust -o jsonpath='{.spec.speaker}'


##Project 3: Monitor Kubernetes pods and send updates to the slack channel
let slack_webhook_url = "Slack webhook URL here"; // Replace with your Slack webhook URL

###run the application
cargo run


In another terminal, deploy any application using a sample YAML:
```