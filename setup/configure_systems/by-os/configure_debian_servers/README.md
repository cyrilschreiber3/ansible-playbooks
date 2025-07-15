configure_debian_servers
========================

This role performs initial configuration for servers running Debian-based operating systems.

Requirements
------------

- Ansible version 2.12+
- Sudo privileges on the host
- A Debian-based system

Role Variables
--------------

### vars/main.yml

None

### defaults/main.yml

None

Dependencies
------------

This role depends on the following local roles:
- `configure_dns_servers`
- `configure_motd_generator`

Example Playbook
----------------

Here is a simple example of how to use this role:

```yaml
- hosts: debian_servers
  gather_facts: true
  roles:
    - role: configure_debian_servers
```

License
-------

Apache 2.0

Author Information
------------------

Cyril Schreiber (https://github.com/cyrilschreiber3)
