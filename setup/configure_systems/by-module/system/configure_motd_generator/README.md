Role Name
=========

Ansible role to install a MOTD generator.

Requirements
------------

-   Ansible 2.18 or higher

Role Variables
--------------

*   `install_dependencies`: (boolean, default: `true`) - Whether to install the necessary dependencies (figlet).
*   `install_motd_binary`: (boolean, default: `true`) - Whether to install the `motd-sysinfo` script.

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- hosts: all
  roles:
    - role: configure_motd_generator
      install_dependencies: true
      install_motd_binary: true
```

License
-------

MIT

Author Information
------------------

Cyril Schreiber
contact@cyrilschreiber.ch
