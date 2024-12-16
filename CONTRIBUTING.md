# Contributing to DevOps Tools Repository

Thank you for considering contributing to our project! 🎉 This repository contains various tools and configurations for DevOps, including **Jenkins**, **Linux**, **Kubernetes**, **AWS**, **Azure**, **Ansible**, **Helm**, and more.

We value your contributions, whether it's fixing bugs, improving documentation, or adding new features. Please follow these guidelines to ensure a smooth process.

---

## General Contribution Guidelines

1. **Fork the Repository**: Always work on your own fork to avoid accidental changes to the main branch.
2. **Open an Issue**: Before starting work, create an issue to discuss your contribution, unless it's a minor change.
3. **Create a Branch**: Use descriptive branch names, e.g., `feature/jenkins-pipeline-update`.
4. **Follow Code Style**: Adhere to the existing style for the tool you're modifying. Use comments and clear commit messages.
5. **Submit a Pull Request**: Link the PR to the corresponding issue and provide a detailed description.

---

## Tool-Specific Guidelines

### Jenkins
- Place Jenkins pipelines and scripts in the `jenkins/` directory.
- Ensure you test pipeline updates with `Jenkinsfile` Linter before submission.

### Kubernetes
- Kubernetes manifests (YAML files) go under `kubernetes/`.
- Add comments in manifests for clarity, especially for configurations like resource limits and security contexts.
- Use Helm for reusable charts and place them in `helm/`.

### Linux
- Linux shell scripts should be placed in `linux/scripts/` and must be executable (`chmod +x`).
- Follow the [ShellCheck](https://www.shellcheck.net/) guidelines to ensure script quality.

### AWS & Azure
- AWS CloudFormation templates should be in `aws/cloudformation/`.
- Azure ARM templates and Bicep scripts go under `azure/arm-templates/` and `azure/bicep/`.

### Ansible
- Ansible playbooks should reside in `ansible/playbooks/`.
- Test all playbooks using `ansible-lint` before submitting.

---

## Testing Contributions
- Test your changes locally or in a sandboxed environment.
- Provide instructions in your pull request for reproducing your results.

---

## Code of Conduct

Please adhere to our [Code of Conduct](CODE_OF_CONDUCT.md) to ensure a respectful and collaborative environment for everyone.

Thank you for your contributions! 🚀
