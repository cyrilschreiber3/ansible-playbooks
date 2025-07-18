# My Ansible Playbooks

This repository contains a collection of Ansible playbooks and roles for managing and configuring various systems in my homelab environment.

## Structure

The repository is organized into several directories:

- **`operations/`**: Utility playbooks for common administrative tasks such as SSH key deployment, connectivity testing, and system validation.
- **`infrastructure/`**: Core infrastructure management roles and playbooks, organized by different categorization approaches:
  - **`by-host/`**: Host-specific configuration playbooks tailored for individual servers.
  - **`by-module/`**: Modular roles for configuring specific system components, applications, and services.
  - **`by-os/`**: Operating system-specific configuration roles (each with standalone playbooks).
- **`ci-cd/`**: Playbooks related to Continuous Integration and Continuous Deployment workflows.

## Usage

These playbooks are intended to be run on my homelab. I try to keep them as modular and reusable as possible but as they are tailored to my specific environment and may not work out of the box on other systems.
