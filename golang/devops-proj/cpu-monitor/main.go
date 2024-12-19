package main

import (
    "context"
    "encoding/json"
    "fmt"
    "log"
    "net/http"
    "os"

    metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
    "k8s.io/client-go/kubernetes"
    "k8s.io/client-go/rest"
    "k8s.io/client-go/tools/clientcmd"
    "k8s.io/metrics/pkg/client/clientset/versioned"
)

type PodMetrics struct {
    Name      string  `json:"name"`
    Namespace string  `json:"namespace"`
    CPUUsage  float64 `json:"cpu_usage"`
}

func getClientset() (*kubernetes.Clientset, *versioned.Clientset, error) {
    config, err := rest.InClusterConfig()
    if err != nil {
        kubeconfig := os.Getenv("KUBECONFIG")
        if kubeconfig == "" {
            kubeconfig = clientcmd.RecommendedHomeFile
        }
        config, err = clientcmd.BuildConfigFromFlags("", kubeconfig)
        if err != nil {
            return nil, nil, err
        }
    }

    clientset, err := kubernetes.NewForConfig(config)
    if err != nil {
        return nil, nil, err
    }

    metricsClientset, err := versioned.NewForConfig(config)
    if err != nil {
        return nil, nil, err
    }

    return clientset, metricsClientset, nil
}

func getPodMetrics(w http.ResponseWriter, r *http.Request) {
    _, metricsClientset, err := getClientset()
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }

    metrics, err := metricsClientset.MetricsV1beta1().PodMetricses("").List(context.TODO(), metav1.ListOptions{})
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }

    var podMetrics []PodMetrics
    for _, item := range metrics.Items {
        for _, container := range item.Containers {
            usage := container.Usage["cpu"]
            cpuUsage, _ := usage.AsInt64()
            podMetrics = append(podMetrics, PodMetrics{
                Name:      item.Name,
                Namespace: item.Namespace,
                CPUUsage:  float64(cpuUsage) / 1000.0,
            })
        }
    }

    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(podMetrics)
}

func main() {
    fs := http.FileServer(http.Dir("web"))
    http.Handle("/", fs)
    http.HandleFunc("/metrics", getPodMetrics)
    fmt.Println("Server is running on port 8080")
    log.Fatal(http.ListenAndServe(":8080", nil))
}