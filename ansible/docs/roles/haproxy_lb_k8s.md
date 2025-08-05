# Role: haproxy_lb_k8s

## Purpose
Installs and configures HAProxy as load balancer for Kubernetes control-plane nodes.

## Main Files
- `tasks/main.yml`: Installs HAProxy and applies template
- `templates/haproxy.j2`: Generates haproxy.cfg
- `handlers/main.yml`: Reloads haproxy if config changes

