open_ports
=========

This role opens network ports on Linux systems using either UFW or firewalld. It automatically detects the firewall service and configures port rules accordingly. If no firewall is installed, it will install and configure UFW.

Requirements
------------
- Sudo privileges on the host
- Ansible >= 2.12

Role Variables
--------------
- `services`: List of service definitions with ports to open (default: [])

Service definition format:
```yaml
services:
  - service_name: "http"
    service_port: 80
    service_protocol: "tcp"
  - service_name: "web-range"
    service_port_range: "8080:8090" # The range can be delimited with "-" or ":"
    service_protocol: "tcp"
```

See `defaults/main.yml` for all configurable variables and examples.

Dependencies
------------
None (standalone role)

Example Playbook
----------------
```yaml
    - hosts: servers
      roles:
        - role: open_ports
          services:
            - service_name: "http"
              service_port: 80
              service_protocol: "tcp"
            - service_name: "https"
              service_port: 443
              service_protocol: "tcp"
```

License
-------
Apache-2.0

Author Information
------------------
Cyril Schreiber (https://github.com/cyrilschreiber3)
