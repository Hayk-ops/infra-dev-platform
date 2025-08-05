# Role: k8s_node_system_prep

## Purpose
Sets required kernel modules, disables swap, and configures sysctl for Kubernetes nodes.

## Main Files
- `tasks/main.yml`: Prepares system settings
- `vars/main.yml`: Kernel/Sysctl values
- `defaults/main.yml`: Optional tuning flags

