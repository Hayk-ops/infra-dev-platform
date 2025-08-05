# Role: join_workers

## Purpose
Joins worker nodes to the cluster using `kubeadm join`.

## Main Files
- `tasks/main.yml`: Executes join command
- `defaults/main.yml`: Basic configuration
- `vars/main.yml`: Join token and discovery info

