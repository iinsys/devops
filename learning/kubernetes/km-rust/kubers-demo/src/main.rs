use kube::{Client, Api};
use kube::api::ListParams;
use k8s_openapi::api::core::v1::Pod;
use std::error::Error;

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error>> {
    // Load the kubeconfig file.
    let config = kube::Config::from_kubeconfig(&kube::config::KubeConfigOptions::default()).await?;
    let client = Client::try_from(config)?;

    // Work with Kubernetes API.
    let pods: Api<Pod> = Api::default_namespaced(client);
    let lp = ListParams::default();

    for p in pods.list(&lp).await? {
        println!("Found Pod: {}", p.metadata.name.unwrap_or_default());
    }

    Ok(())
}
