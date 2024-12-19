### Building a Monitoring Tool for Kubernetes

### Architecture

1. **Go Application:**
   - Fetches CPU metrics from the Kubernetes API.
   - Serves the data via an HTTP endpoint.

2. **Frontend:**
   - Simple HTML page to display the fetched metrics.

3. **Kubernetes Deployment:**
   - Dockerized Go application.
   - Deployment and Service YAML files for Kubernetes.

### Conclusion

This simple project will help you understand how to interact with the Kubernetes API using Go, serve data over HTTP, and display it using a simple web interface. By deploying it on Minikube, you also gain hands-on experience with Kubernetes deployments and services.


### Deploying application
### CPU Monitor

This project is a simple monitoring tool to monitor CPU utilization of pods in a Kubernetes cluster. It is built using Go and provides a simple web interface to display the data.

## Prerequisites

- Minikube or any Kubernetes cluster
- Docker
- kubectl

## Setup

1. **Clone the repository:**
```sh
git clone https://github.com/bansikah22/devops/golang/devops-proj/cpu-monitor.git

cd cpu-monitor

## Also install these two packages at the root of the project to get the cpu utilization data
go mod tidy
go get k8s.io/client-go@v0.22.0
go get k8s.io/api@v0.22.0
go get k8s.io/metrics/pkg/client/clientset/versioned
go mod vendor


## you can package and push your own docker image
docker build -t bansikah/cpu-monitor:latest .
docker push bansikah/cpu-monitor:latest

## On your cluster
kubectl get nodes

## Deploy application using manifest files on cluster
cd k8s 
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

## Access the service
minikube service cpu-monitor
```
**Note**
- Ensure you have the Kubernetes metrics server installed in your cluster to fetch the metrics.
- The application can be tested on any Kubernetes cluster by following the above steps.
