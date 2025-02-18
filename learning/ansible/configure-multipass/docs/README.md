# Configure Multipass Project Structure

This document provides an overview of the project structure for the Configure Multipass Ansible setup. Each directory and file serves a specific purpose in managing the configuration and deployment of applications across different environments.

## Project Structure

```
configure-multipass/
├── docs/                        # Documentation directory
│   └── README.md                # Documentation explaining the project structure
├── inventory/                   # Contains inventory files for different environments
│   ├── staging/                 # Inventory for staging environment
│   │   └── hosts.ini            # Hosts configuration for staging
│   └── production/              # Inventory for production environment
│       └── hosts.ini            # Hosts configuration for production
├── playbooks/                   # Contains playbooks for various tasks
│   ├── file_management.yml       # Playbook for managing files on remote hosts
│   ├── package_management.yml    # Playbook for managing packages on remote hosts
│   ├── service_management.yml    # Playbook for managing services on remote hosts
│   ├── install_docker.yml        # Playbook for installing Docker
│   └── install_git.yml           # Playbook for installing Git
├── roles/                       # Contains roles for reusable tasks and handlers
│   └── common/                  # Common role for shared tasks and handlers
│       ├── tasks/               # Directory for task definitions
│       │   └── main.yml         # Main tasks file for the common role
│       └── handlers/            # Directory for handlers
│           └── main.yml         # Main handlers file for the common role
└── ansible.cfg                  # Ansible configuration file specifying defaults
```

## Directory and File Descriptions

- **docs/**: This directory contains documentation files that explain the project structure and usage.

- **inventory/**: This directory contains inventory files that define the hosts and groups of hosts for different environments (staging and production).

- **playbooks/**: This directory contains playbooks that define the tasks to be executed on the hosts. Each playbook is focused on a specific area of management, such as file handling, package management, and service management.

- **roles/**: This directory contains roles that encapsulate reusable tasks and handlers. The `common` role includes tasks and handlers that can be reused across different playbooks.

- **ansible.cfg**: This configuration file sets default values for Ansible, including the location of the inventory files.

## How to Run the Project

To run the Ansible playbooks in this project, follow these steps:

1. **Install Ansible**: Ensure that Ansible is installed on your machine. You can install it using pip:
   ```bash
   pip install ansible
   ```

2. **Navigate to the Project Directory**: Open a terminal and navigate to the `configure-multipass` directory:
   ```bash
   cd devops/learning/ansible/configure-multipass
   ```

3. **Run a Playbook**: Use the `ansible-playbook` command to execute a specific playbook. For example, to install Docker, run:
   ```bash
   ##test inventory
   ansible-inventory -i inventory/staging/hosts.ini --list

   ansible-playbook playbooks/install_docker.yml -i inventory/production/hosts.ini
   ```

4. **Run Other Playbooks**: Similarly, you can run other playbooks by specifying their names. For example, to install Git:
   ```bash
   ansible-playbook playbooks/install_git.yml -i inventory/staging/hosts.ini
   ```

5. **Check the Status**: After running the playbooks, you can check the status of the services or configurations as needed.

## Conclusion

This project structure is designed to facilitate the management of configurations and deployments across different environments using Ansible. Each component is organized to promote clarity and reusability, making it easier to maintain and extend the setup as needed.
