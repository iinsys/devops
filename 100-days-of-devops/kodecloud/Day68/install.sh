#!/bin/bash
# install.sh - Install Jenkins on CentOS/RHEL using yum (official method)
# Reference: https://www.jenkins.io/doc/book/installing/linux/#red-hat-centos

set -e

# 1. Install Java (Jenkins requires Java 17+)
yum install -y java-17-openjdk

# 2. Add Jenkins repo and import key
curl --silent --location https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key | sudo tee /etc/pki/rpm-gpg/RPM-GPG-KEY-jenkins.io > /dev/null
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
cat <<EOF > /etc/yum.repos.d/jenkins.repo
[jenkins]
name=Jenkins-stable
baseurl=https://pkg.jenkins.io/redhat-stable
gpgcheck=1
gpgkey=https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
enabled=1
EOF

# 3. Install Jenkins
yum install -y jenkins

# 4. Enable and start Jenkins service
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins

# 5. Show initial admin password
echo "\nJenkins installed. To complete setup, access the UI and use the following initial admin password:"
cat /var/lib/jenkins/secrets/initialAdminPassword
