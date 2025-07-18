rhel
=======================

Ansible role to perform initial configuration on Red Hat Enterprise Linux (RHEL) servers.

Requirements
------------

- Ansible version 2.12+
- Sudo privileges on the host
- A Red Hat Enterprise Linux based system
- The `community.general` collection must be installed
- A valid Red Hat subscription with an activation key and organization ID

Role Variables
--------------

### vars/main.yml

- `redhat_activation_key`: The activation key for Red Hat subscription.
  - Type: string
  - Default: None (Required)
- `redhat_org_id`: The organization ID for Red Hat subscription.
  - Type: string
  - Default: None (Required)

### defaults/main.yml

None

Dependencies
------------

None.

Example Playbook
----------------

Here is a simple example of how to use this role:

```yaml
- hosts: rhel_servers
  gather_facts: true
  roles:
    - role: rhel
      vars:
        redhat_activation_key: "{{ vault_redhat_activation_key }}"
        redhat_org_id: "{{ vault_redhat_org_id }}"
```

License
-------

Apache 2.0

Author Information
------------------

Cyril Schreiber (https://github.com/cyrilschreiber3)
