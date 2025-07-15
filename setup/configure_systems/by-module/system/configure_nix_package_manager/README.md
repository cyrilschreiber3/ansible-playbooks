configure_nix_package_manager
=============================

This role installs and configures the Nix package manager on Linux systems. It supports declarative configuration using Nix flakes and can optionally configure shell environments (bash/zsh) and custom profiles.

Requirements
------------
- Linux system with internet access
- Sudo privileges for installation
- Python >= 3.8 (for Ansible)

Role Variables
--------------
- `nix_version`: Version of Nix to install (default: 2.29.1)
- `nix_build`: Build string for Nix installer
- `installer_path`: URL for Nix installer
- `default_nix_profiles`: List of default Nix profiles to install
- `extra_nix_profiles`: Additional profiles to install
- `flakes`: Enable Nix flakes (default: true)
- `nix_commands`: List of custom Nix commands to run after install
- `configure_bash`: Configure bash shell for Nix (default: false)
- `configure_zsh`: Configure zsh shell for Nix (default: false)

See `defaults/main.yml` for all configurable variables.

Dependencies
------------
None (standalone role)

Example Playbook
----------------
```yaml
- hosts: servers
  roles:
    - role: configure_nix_package_manager
      nix_version: 2.29.1
      flakes: true
      configure_zsh: true
```

License
-------
Apache-2.0

Author Information
------------------
Cyril Schreiber (https://github.com/cyrilschreiber3)
