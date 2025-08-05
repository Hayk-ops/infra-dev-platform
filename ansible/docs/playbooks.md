# Playbooks Overview

## configure-system-requirements.yaml
Runs the `system_prerequisites` role on all nodes.

## install-kubeadm.yaml
Installs kubeadm dependencies (kubelet, kubeadm, kubectl) using:
- `kubernetes_apt_repo`
- `kube_components`

## k8s-masters-loadbalancer-setup.yaml
Configures the load balancer using `haproxy_lb_k8s` role.

## kubeadm-init-master1.yml
Initializes the first control-plane node using `kube_init_master1`.

## kubeadm-join-masters.yml
Joins remaining masters using `join_masters`.

## kubeadm-join-workers.yml
Joins worker nodes using `join_workers`.

