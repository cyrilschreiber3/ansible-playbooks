configure_dns_servers
=====================

This role configures DNS servers on Linux systems by managing `/etc/resolv.conf` using Ansible. It supports custom nameservers, search domains, and options for flexible DNS configuration.

Requirements
------------
- Linux system
- Sudo privileges for file management
- Ansible >= 2.18

Role Variables
--------------
- `dns_servers`: List of DNS servers to configure (default: internal Schreibernet and public servers)
- `search_domains`: List of search domains (default: ["schreibernet.dev"])
- `options`: List of custom options for `resolv.conf`

See `defaults/main.yml` for all configurable variables.

Dependencies
------------
None (standalone role)

Example Playbook
----------------
    - hosts: all
      roles:
        - role: configure_dns_servers
          dns_servers:
            - "8.8.8.8"
            - "1.1.1.1"
          search_domains:
            - "example.com"
          options:
            - "timeout:2"

License
-------
Apache-2.0

Author Information
------------------
Cyril Schreiber (https://github.com/cyrilschreiber3)
