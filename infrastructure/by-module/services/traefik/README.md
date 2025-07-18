traefik
=======

This Ansible role installs and configures Traefik, a modern reverse proxy and load balancer. The role automatically downloads the latest version of Traefik from GitHub, installs it on the target hosts, and configures it with appropriate firewall rules.

> [!NOTE]
> This role is designed specifically for my implementation of Traefik for my reverse proxy servers. It doesn't include any configuration for Traefik itself as it is managed separately in my infrastructure setup.

Requirements
------------

- Ansible version 2.12+
- Target hosts running Alpine Linux (OpenRC init system support)
- Sudo privileges on the host
- Required Ansible collections:
  - `ansible.posix` (for firewalld module)
  - `community.general` (for ufw module)

Role Variables
--------------

### defaults/main.yml

- `traefik_bin_path`: Path where the Traefik binary will be installed
  - Type: string
  - Default: `/usr/sbin/traefik`

### vars/main.yml

- `infomaniak_api_key`: Encrypted API key for Infomaniak DNS provider (used for Let's Encrypt ACME challenges)
  - Type: string (Ansible Vault encrypted)
  - This variable is required for DNS-01 ACME challenges with Infomaniak

### Task-defined Variables

The role automatically sets the following variables during execution:
- `traefik_latest_version`: Latest version available on GitHub
- `traefik_current_version`: Currently installed version (if any)
- `traefik_arch`: Target architecture (extracted from system)
- `traefik_download_url`: Download URL for the latest Traefik binary

Dependencies
------------

None.


Example Playbook
----------------

### Using the Role Directly

```yaml
---
- name: Install Traefik on proxy servers
  hosts: proxy_servers
  become: yes
  roles:
    - role: traefik
```

### Using the Provided Playbook

There is a ready-to-use playbook file (`playbook.ansible.yml`) at the root of this role that you can run directly:

```bash
ansible-playbook ansible-playbooks/infrastructure/by-module/services/traefik/playbook.ansible.yml
```

The playbook targets the `proxy_servers` group and applies the Traefik role to all hosts in that group.

License
-------

Apache 2.0

Author Information
------------------

Cyril Schreiber (https://github.com/cyrilschreiber3)
