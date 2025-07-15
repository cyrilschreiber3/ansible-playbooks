# My Ansible Playbooks

This repository contains a collection of Ansible playbooks and roles for managing and configuring various systems in my homelab environment.

## Structure

> [!NOTE]
> The current structure will be reworked in the future to better suit my new approach to managing my homelab.

The repository is organized into several directories:

- **`ci-cd/`**: Playbooks related to Continuous Integration and Continuous Deployment.
- **`debug/`**: Playbooks used for debugging and testing connectivity.
- **`setup/`**: Contains roles and playbooks for initial server setup and configuration. This is the core of the repository, with roles organized by operating system, module, and host.
  - **`configure_systems/`**: Contains roles for configuring systems.
    - **`by-host/`**: Playbooks for each hosts.
    - **`by-module/`**: Roles for configuring parts of the system, apps and services.
    - **`by-os/`**: Roles for configuring systems by operating system. Each role has its own playbook to run it standalone.

## Usage

These playbooks are intended to be run on my homelab. I try to keep them as modular and reusable as possible but as they are tailored to my specific environment and may not work out of the box on other systems.
