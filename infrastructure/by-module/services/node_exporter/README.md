node_exporter
=============

This Ansible role installs and configures Prometheus Node Exporter, a system metrics collector that exposes hardware and OS metrics for monitoring. The role supports multiple operating systems and can automatically detect and install the latest version from GitHub releases.

Requirements
------------

- Ansible version 2.12+
- Sudo privileges on the host
- Supported operating systems:
  - RedHat/CentOS/Fedora (using geerlingguy.node_exporter role)
  - Debian/Ubuntu (using geerlingguy.node_exporter role)
  - Alpine Linux (manual installation)

Role Variables
--------------

### defaults/main.yml

- `ne_version`: Version of Node Exporter to install
  - Type: string
  - Default: `latest`

- `ne_host`: IP address for Node Exporter to bind to
  - Type: string
  - Default: `0.0.0.0`

- `ne_port`: Port for Node Exporter to listen on
  - Type: integer
  - Default: `9200`

### vars/main.yml

- `node_exporter_options`: Command-line options for Node Exporter
  - Type: string
  - Default: `--collector.systemd --collector.processes`

### Task-defined Variables

The role automatically sets the following variables during execution:
- `node_exporter_version`: Resolved version number (when `ne_version` is set to `latest`)
- `node_exporter_arch`: Target architecture (`amd64` or `arm64`)
- `node_exporter_download_url`: Download URL for the Node Exporter binary
- `node_exporter_bin_path`: Path to the Node Exporter binary (`/usr/local/bin/node_exporter` for Alpine)

Dependencies
------------

- `geerlingguy.node_exporter` (for non-Alpine systems)

Example Playbook
----------------

### Using the Role Directly

```yaml
---
- name: Install Node Exporter on all servers
  hosts: monitoring_targets
  become: yes
  roles:
    - role: node_exporter
```

### Using the Provided Playbook

There is a ready-to-use playbook file (`playbook.ansible.yml`) at the root of this role that you can run directly:

```bash
ansible-playbook ansible-playbooks/infrastructure/by-module/services/node_exporter/playbook.ansible.yml
```

The playbook targets `all` hosts except `mercury-fs-01` and `idris-hv-01` and applies the Node Exporter role to enable metrics collection.

License
-------

Apache 2.0

Author Information
------------------

Cyril Schreiber (https://github.com/cyrilschreiber3)
