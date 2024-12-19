async function fetchMetrics() {
    try {
        const response = await fetch('/metrics');
        const data = await response.json();
        let output = '<table><tr><th>Pod Name</th><th>Namespace</th><th>CPU Usage (millicores)</th></tr>';
        data.forEach(metric => {
            output += `<tr><td>${metric.name}</td><td>${metric.namespace}</td><td>${metric.cpu_usage}</td></tr>`;
        });
        output += '</table>';
        document.getElementById('metrics').innerHTML = output;
    } catch (error) {
        console.error('Error fetching metrics:', error);
    }
}

window.onload = fetchMetrics;