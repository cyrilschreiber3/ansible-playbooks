configure_rhel_servers
=======================

Ansible role to configure servers running Red Hat Enterprise Linux (RHEL). This role handles Red Hat subscription, repository setup, RHC installation, and system configuration for RHEL hosts.

Requirements
------------
- Ansible 2.18+
- Access to Red Hat subscription (activation key and org ID)
- Community modules: `community.general`

Role Variables
--------------
Variables can be set in inventory, playbook, or via extra vars:
- `redhat_activation_key` (**required**): Red Hat subscription activation key (vault-encrypted)
- `redhat_org_id` (**required**): Red Hat organization ID (vault-encrypted)

Other variables are set internally for repository and system configuration.

See `defaults/main.yml` for all configurable variables.

Dependencies
------------
None (standalone role)

Example Playbook
----------------
```yaml
- hosts: rhel_servers
  gather_facts: true
  roles:
    - role: configure_rhel_servers
      vars:
        configure_rhel_servers_redhat_activation_key: "{{ vault_redhat_activation_key }}"
        configure_rhel_servers_redhat_org_id: "{{ vault_redhat_org_id }}"
```

License
-------
Apache-2.0

Author Information
------------------
Cyril Schreiber (https://github.com/cyrilschreiber3)
