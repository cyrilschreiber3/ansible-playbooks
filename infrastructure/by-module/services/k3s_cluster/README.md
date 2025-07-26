k3s_cluster
===========

This Ansible role installs and configures a highly available (HA) K3s Kubernetes cluster. The role supports both single-node and multi-master cluster deployments with automatic load balancing using kube-vip. It handles the complete setup from prerequisites to cluster initialization and includes support for various networking configurations and firewall rules.

Requirements
------------

- Ansible version 2.14+
- Sudo privileges on the host
- Supported operating systems:
  - RedHat/CentOS/Fedora
  - Debian/Ubuntu

Role Variables
--------------

### defaults/main.yml

- `k3s_version`: Version of K3s to install
  - Type: string
  - Default: `v1.33.1+k3s1`

- `ansible_user`: User that has SSH access to the machines
  - Type: string
  - Default: `admin`

- `systemd_dir`: Directory for systemd service files
  - Type: string
  - Default: `/etc/systemd/system`

- `k3s_server_location`: K3s server data directory
  - Type: string
  - Default: `/var/lib/rancher/k3s`

- `k3s_create_kubectl_symlink`: Create kubectl symlink
  - Type: boolean
  - Default: `true`

- `config_user_kubectl`: Configure kubectl access for the ansible user
  - Type: boolean
  - Default: `true`

- `master_group`: Inventory group name for master nodes
  - Type: string
  - Default: `masters`

- `worker_group`: Inventory group name for worker nodes
  - Type: string
  - Default: `workers`

- `flannel_iface`: Network interface for Flannel CNI
  - Type: string
  - Default: `eth0`

- `apiserver_endpoint`: Virtual IP address for the API server (HA)
  - Type: string
  - Default: `192.168.30.222`

- `apiserver_port`: Port for the Kubernetes API server
  - Type: integer
  - Default: `6443`

- `apiserver_aliases`: Additional hostnames/IPs for API server TLS certificate
  - Type: list
  - Default: `[]`

- `k3s_token`: Secure token for cluster communication
  - Type: string
  - Default: `some-SUPER-DEDEUPER-secret-password`
  - **Note**: This should be changed to a secure random value (e.g., using `openssl rand -base64 64`)

- `k3s_node_ip`: IP address on which the node is reachable in the cluster
  - Type: string
  - Default: `"{{ lookup('vars', ('ansible_' + flannel_iface)).ipv4.address }}"` (the address of the interface used for Flannel)

- `k3s_master_taint`: Whether to apply NoSchedule taint to master nodes. This prevents scheduling workloads on master nodes unless explicitly allowed.
  - Type: boolean
  - Default: `true` if worker nodes exist, `false` otherwise

- `kube_vip_tag_version`: Image tag for kube-vip
  - Type: string
  - Default: `v0.9.2`

- `kube_vip_lb_ip_range`: IP range for kube-vip load balancer services
  - Type: string
  - Default: undefined (commented out)
  - Example: `"192.168.30.80-192.168.30.90"`

- `kube_vip_arp`: Enable kube-vip ARP broadcasts
  - Type: boolean
  - Default: `true`

### Computed Variables

The role automatically computes several variables during execution:
- `extra_args`: Common arguments for both servers and agents
- `extra_server_args`: Additional arguments for K3s server nodes
- `extra_agent_args`: Additional arguments for K3s agent nodes
- `server_init_args`: Arguments for cluster initialization

### Optional Variables

- `server_config_yaml`: YAML configuration for K3s server
  - Type: string (YAML format)
  - Used to define cluster-cidr, service-cidr, and other K3s configurations

- `extra_service_envs`: Additional environment variables for K3s service
  - Type: list

Cluster Architecture
-------------------

The role supports two deployment modes:

1. **Single Master**: Simple deployment with one control plane node
2. **High Availability**: Multi-master deployment with:
   - Embedded etcd datastore
   - kube-vip for virtual IP management
   - Automatic load balancing between masters

Dependencies
------------

- `open_ports` role (automatically included for firewall configuration)

Example Playbook
----------------

### Basic Single Master Setup

```yaml
---
- name: Deploy K3s single master cluster
  hosts: k3s_masters
  become: yes
  roles:
    - role: k3s_cluster
      vars:
        k3s_version: v1.33.1+k3s1
        master_group: k3s_masters
        flannel_iface: eth0
        k3s_token: "your-secure-token-here"
```

### High Availability Cluster

```yaml
---
- name: Deploy K3s HA cluster
  hosts: vanguard_cluster
  become: yes
  roles:
    - role: k3s_cluster
      vars:
        k3s_version: v1.33.1+k3s1
        master_group: cluster_masters
        worker_group: cluster_workers
        flannel_iface: "{{ ansible_default_ipv4.interface }}"
        apiserver_endpoint: 10.1.1.123
        apiserver_aliases:
          - "cluster.example.com"
          - "k8s-api.example.com"
        k3s_token: "{{ vault_k3s_token }}"
        server_config_yaml: |
          cluster-cidr: 10.42.0.0/16
          service-cidr: 10.43.0.0/16
        kube_vip_lb_ip_range: "10.1.1.80-10.1.1.90"
```

### Inventory Requirements

The role expects hosts to be organized in groups:

```ini
[cluster_masters]
master-01 ansible_host=10.1.1.10
master-02 ansible_host=10.1.1.11
master-03 ansible_host=10.1.1.12

[cluster_workers]
worker-01 ansible_host=10.1.1.20
worker-02 ansible_host=10.1.1.21

[k3s_cluster:children]
cluster_masters
cluster_workers
```

Post-Installation
-----------------

After successful deployment, the role provides:
- kubectl access configured for the ansible user
- Bash completion for kubectl and k3s commands
- systemd service for automatic startup
- High availability API server endpoint (in HA mode)

To access the cluster:
```bash
# On any master node
kubectl get nodes
kubectl get pods -A
```

License
-------

Apache-2.0

Author Information
------------------

Cyril Schreiber
