configure_nix_package_manager
=============================

This role installs and configures the Nix package manager on Linux systems.

Requirements
------------

- Ansible version 2.12+
- Sudo privileges on the host

Role Variables
--------------

### vars/main.yml

None

### defaults/main.yml

- `nix_version`: The version of Nix to install.
  - Type: string
  - Default: `2.29.1`
- `nix_build`: The build string for the Nix installer.
  - Type: string
  - Default: `nix-{{ nix_version }}-x86_64-linux`
- `installer_path`: The URL for the Nix installer.
  - Type: string
  - Default: `https://releases.nixos.org/nix/nix-{{ nix_version }}/{{ nix_build }}.tar.xz`
- `default_nix_profiles`: A list of default Nix profiles to install.
  - Type: list
  - Default: `[ "mainconfig", "{{ ansible_hostname | lower | replace('-', '_') }}" ]`
- `extra_nix_profiles`: A list of additional Nix profiles to install.
  - Type: list
  - Default: `[]`
- `flakes`: Whether to enable Nix flakes.
  - Type: boolean
  - Default: `true`
- `nix_commands`: A list of custom Nix commands to run after installation.
  - Type: list
  - Default: `[]`
- `configure_bash`: Whether to configure the bash shell for Nix.
  - Type: boolean
  - Default: `false`
- `configure_zsh`: Whether to configure the zsh shell for Nix.
  - Type: boolean
  - Default: `false`

Dependencies
------------

None.

Example Playbook
----------------

Here is a simple example of how to use this role:

```yaml
- hosts: servers
  roles:
    - role: configure_nix_package_manager
      vars:
        configure_zsh: true
        extra_nix_profiles:
          - "my_custom_profile"
```

License
-------

Apache 2.0

Author Information
------------------

Cyril Schreiber (https://github.com/cyrilschreiber3)
