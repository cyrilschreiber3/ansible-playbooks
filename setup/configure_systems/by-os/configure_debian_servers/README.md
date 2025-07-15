configure_debian_servers
========================

This role configures servers running Debian. It installs basic packages, manages user groups, and imports roles for DNS server configuration and MOTD generation.

Requirements
------------
- Debian-based Linux system
- Sudo privileges for package and user management
- Ansible >= 2.18

Role Variables
--------------
No default variables are set. You may override variables for imported roles (e.g., `configure_dns_servers`, `configure_motd_generator`).

Dependencies
------------
- `configure_dns_servers` (for DNS configuration)
- `configure_motd_generator` (for MOTD setup)

Example Playbook
----------------
```yaml
- hosts: debian_servers
  roles:
    - role: configure_debian_servers
```
License
-------
Apache-2.0

Author Information
------------------
Cyril Schreiber (https://github.com/cyrilschreiber3)
