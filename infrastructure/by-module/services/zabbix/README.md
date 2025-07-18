zabbix
======

This Ansible role installs and configures the Zabbix agent on Linux systems. The role supports multiple operating systems and distributions, automatically detects system characteristics, and configures the agent to communicate with a Zabbix server for monitoring purposes.

Requirements
------------

- Ansible version 2.9+
- Sudo privileges on the host
- Supported operating systems:
  - RedHat/CentOS/Fedora
  - Debian/Ubuntu
  - Alpine Linux

Role Variables
--------------

### defaults/main.yml

- `zabbix_server`: IP address or hostname of the Zabbix server
  - Type: string
  - Default: `10.1.1.21`

- `zabbix_release`: Version of Zabbix to install
  - Type: string
  - Default: `7.2`

- `agent_variant`: Zabbix agent version variant (1 or 2)
  - Type: integer
  - Default: `2`

### vars/main.yml

- `agent_param_server`: Address of Zabbix server to accept connections from
  - Type: string
  - Default: `"{{ zabbix_server }}"`

- `agent_param_serveractive`: Address of Zabbix server to connect using active checks
  - Type: string
  - Default: `""` (empty)

- `agent_param_listenip`: IP address for Zabbix agent to listen on
  - Type: string
  - Default: `0.0.0.0`

- `agent_param_listenport`: Port for Zabbix agent to listen on
  - Type: integer
  - Default: `10050`

### Task-defined Variables

The role automatically sets the following variables during execution:
- `custom_group_names`: Dynamically generated groups based on server characteristics (Docker, virtualization, hostname patterns)
- `agent_variant_version`: Computed agent version string based on the agent_variant setting

Host Classification
-------------------

The role automatically classifies hosts into groups based on system characteristics:
- **docker_host**: Hosts with Docker installed (detected by `ansible_docker0` interface)
- **vm**: Virtual machines (based on `ansible_virtualization_type`)
- **lxc**: Linux containers (based on `ansible_virtualization_type`)
- **bare_metal**: Physical servers
- **Hostname-based groups**: Extracted from hostname patterns (e.g., `dns`, `pxy`, `hv`)
- **Distribution groups**: Based on `ansible_distribution`

Dependencies
------------

None.

Example Playbook
----------------

### Using the Role Directly

```yaml
---
- name: Install and configure Zabbix agent
  hosts: monitoring_targets
  become: yes
  roles:
    - role: zabbix
```

### Using the Provided Playbook

There is a ready-to-use playbook file (`playbook.ansible.yml`) at the root of this role that you can run directly:

```bash
ansible-playbook ansible-playbooks/infrastructure/by-module/services/zabbix/playbook.ansible.yml
```

The playbook targets `all` hosts except `mercury-fs-01` and `idris-hv-01` and applies the Zabbix role to configure monitoring.

License
-------

Apache 2.0

Author Information
------------------

Cyril Schreiber (https://github.com/cyrilschreiber3)
