use kube::{Client, Api};
use kube::runtime::watcher;
use k8s_openapi::api::core::v1::Pod;
use tokio;
use reqwest;
use serde_json::json;
use futures_util::TryStreamExt;
use tokio::sync::mpsc;


async fn send_slack_message(client: &reqwest::Client, webhook_url: &str, messages: Vec<String>) {
    let payload = json!({ "text": messages.join("\n") });
    if let Err(e) = client.post(webhook_url)
        .json(&payload)
        .send()
        .await {
        eprintln!("Failed to send message to Slack: {}", e);
    }
}


#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let client = Client::try_default().await?;
    let pods: Api<Pod> = Api::all(client);
    let watcher = watcher(pods, Default::default());

    let slack_webhook_url = "https://hooks.slack.com/services/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"; // Replace with your Slack webhook URL
    let reqwest_client = reqwest::Client::new();

    let (tx, mut rx) = mpsc::channel(100);

    // Task to batch and send Slack messages periodically
    let webhook_task = tokio::spawn(async move {
        let mut messages = Vec::new();
        while let Some(message) = rx.recv().await {
            messages.push(message);
            if messages.len() >= 10 {
                send_slack_message(&reqwest_client, slack_webhook_url, messages.split_off(0)).await;
            }
        }
        if !messages.is_empty() {
            send_slack_message(&reqwest_client, slack_webhook_url, messages).await;
        }
    });

    tokio::pin!(watcher);
    while let Some(event) = watcher.try_next().await? {
        if let watcher::Event::Applied(pod) = event {
            let pod_name = pod.metadata.name.unwrap_or_default();
            let message = format!("Pod update: {}", pod_name);
            tx.send(message).await?;
        }
    }

    drop(tx); // Close the channel to stop the webhook task
    webhook_task.await?;

    Ok(())
}
