dns_servers
=====================

This role configures DNS name resolution on Linux systems by managing the `/etc/resolv.conf` file.

Requirements
------------

- Ansible version 2.12+
- Sudo privileges on the host

Role Variables
--------------

### vars/main.yml

None

### defaults/main.yml

- `search_domains`: A list of DNS search domains.
  - Type: list
  - Default: `["schreibernet.dev"]`
- `options`: A list of options for `resolv.conf`.
  - Type: list
  - Default: `[]`

### Task-defined Variables

- `dns_servers`: A list of nameserver IP addresses.
  - Type: list
  - Default: A list of internal and public DNS servers is dynamically set if the variable is not defined.

Dependencies
------------

None.

Example Playbook
----------------

Here is a simple example of how to use this role:

```yaml
- hosts: all
  roles:
    - role: dns_servers
      vars:
        dns_servers:
          - "8.8.8.8"
          - "1.1.1.1"
        search_domains:
          - "example.com"
        options:
          - "timeout:2"
```

License
-------

Apache 2.0

Author Information
------------------

Cyril Schreiber (https://github.com/cyrilschreiber3)
