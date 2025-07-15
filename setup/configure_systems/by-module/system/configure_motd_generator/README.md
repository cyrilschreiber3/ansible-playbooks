configure_motd_generator
========================

This role installs and configures a dynamic MOTD (Message of the Day) generator for Linux systems. It provides system information and a custom welcome message using a shell script and figlet.

Requirements
------------
- Linux system
- Sudo privileges for installation
- Ansible >= 2.18

Role Variables
--------------
- `install_dependencies`: Install required packages (figlet) [default: true]
- `install_motd_binary`: Install the motd-sysinfo script [default: true]

See `defaults/main.yml` for all configurable variables.

Dependencies
------------
None (standalone role)

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
Apache-2.0

Author Information
------------------
Cyril Schreiber (https://github.com/cyrilschreiber3)
