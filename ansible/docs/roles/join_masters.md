# Role: join_masters

## Purpose
Joins additional control-plane nodes to Kubernetes cluster using `kubeadm join`.

## Main Files
- `tasks/main.yml`: Executes join command with `--control-plane` flag
- `defaults/main.yml`: Join command template variables

