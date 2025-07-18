configure_motd_generator
========================

This role installs and configures a dynamic Message of the Day (MOTD) generator on Linux systems.

Requirements
------------

- Ansible version 2.12+
- Sudo privileges on the host

Role Variables
--------------

### vars/main.yml

None

### defaults/main.yml

- `install_dependencies`: Whether to install required packages (e.g., figlet).
  - Type: boolean
  - Default: `true`
- `install_motd_binary`: Whether to install the `motd-sysinfo` script.
  - Type: boolean
  - Default: `true`

Dependencies
------------

None.

Example Playbook
----------------

Here is a simple example of how to use this role:

```yaml
- hosts: all
  roles:
    - role: configure_motd_generator
```

License
-------

Apache 2.0

Author Information
------------------

Cyril Schreiber (https://github.com/cyrilschreiber3)
