# Role: kube_init_master1

## Purpose
Initializes the first control-plane node using `kubeadm init`.

## Main Files
- `tasks/main.yml`: Runs `kubeadm init` with `--control-plane-endpoint`, uploads certs
- `defaults/main.yml`: Contains CIDR, API endpoint, etc.

