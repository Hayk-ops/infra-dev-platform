variable "resource_group_info" {
  type = object({
    name     = string
    location = string
  })
}

variable "cluster_name" {
  type = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS control‑plane FQDN"
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9][A-Za-z0-9-]{0,52}[A-Za-z0-9]$", var.dns_prefix))
    error_message = <<EOT
dns_prefix must:
 • start and end with a letter or digit,
 • contain only letters, digits, and hyphens,
 • be 1–54 characters long.
EOT
  }
}

variable "default_node_pool" {
  type = object({
    name       = string
    node_count = number
    vm_size    = string
    type       = string
    # zones      = list(string)
  })
}

variable "identity" {
  type = object({
    type = string
  })
}

variable "tags" {
  type = object({
    environment = string
  })
}
