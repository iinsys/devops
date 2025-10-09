pipeline {
    agent any

    stages {
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                
                // Clone the repository (no credentials needed for public repo)
                git url: 'http://git.stratos.xfusioncorp.com/sarah/web.git', branch: 'master'
                
                // Copy files to storage server using shell commands
                sh '''
                    echo "Deploying files to storage server..."
                    
                    # Method 1: If Jenkins can access shared storage directly
                    if [ -d "/var/www/html" ] && [ -w "/var/www/html" ]; then
                        echo "Direct access to shared storage"
                        cp -r * /var/www/html/
                        echo "Direct copy completed"
                    else
                        # Method 2: Using SCP 
                        echo "Using SCP to transfer files"
                        
                        # First, verify what content we have locally
                        echo "DEBUG: Local index.html content:"
                        cat index.html || echo "No index.html found locally"
                        
                        # Create correct content if needed (uncomment if repository content is wrong)
                        # echo "Welcome to xFusionCorp Industries" > index.html
                        # echo "DEBUG: Updated local index.html content:"
                        # cat index.html
                        
                        # Transfer files
                        sshpass -p "Bl@kW" scp -o StrictHostKeyChecking=no -r index.html natasha@ststor01:/var/www/html/
                        
                        # Verify content on remote server
                        echo "DEBUG: Remote index.html content:"
                        sshpass -p "Bl@kW" ssh -o StrictHostKeyChecking=no natasha@ststor01 "cat /var/www/html/index.html"
                        
                        # Fix permissions using echo to pass password to sudo
                        echo "Bl@kW" | sshpass -p "Bl@kW" ssh -o StrictHostKeyChecking=no natasha@ststor01 "sudo -S chown -R apache:apache /var/www/html 2>/dev/null || true"
                        echo "Bl@kW" | sshpass -p "Bl@kW" ssh -o StrictHostKeyChecking=no natasha@ststor01 "sudo -S chmod -R 755 /var/www/html 2>/dev/null || true"
                        
                        echo "SCP deployment completed"
                    fi
                    
                    echo "Deployment completed successfully"
                '''
            }
        }

        stage('Test') {
            steps {
                echo 'Testing deployment...'
                
                script {
                    def expectedContent = 'Welcome to xFusionCorp Industries'
                    
                    // Wait a moment for deployment to propagate
                    sleep(5)
                    
                    try {
                        // Test Load Balancer URL
                        def lbResponse = sh(script: 'curl -s http://stlb01:8091/', returnStdout: true).trim()
                        echo "DEBUG: Load balancer response: ${lbResponse}"
                        echo "DEBUG: Expected content: ${expectedContent}"
                        
                        if (!lbResponse.contains(expectedContent)) {
                            error("Load balancer test failed. Expected content '${expectedContent}' not found in response: '${lbResponse}'")
                        }
                        echo " Load balancer test passed"
                        
                        // Test individual app servers
                        ['stapp01:8080', 'stapp02:8080', 'stapp03:8080'].each { server ->
                            def response = sh(script: "curl -s http://${server}/", returnStdout: true).trim()
                            if (!response.contains(expectedContent)) {
                                error("App server ${server} test failed")
                            }
                            echo " ${server} test passed"
                        }
                        
                        echo 'All tests passed successfully!'
                        
                    } catch (Exception e) {
                        error("Test stage failed: ${e.getMessage()}")
                    }
                }
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}