output "network_security_rules_info" {
  value = {
    for key, rule in azurerm_network_security_rule.dev_rg_net_sec_rule :
    key => {
      name                   = rule.name
      priority               = rule.priority
      destination_port_range = rule.destination_port_range
      protocol               = rule.protocol
    }
  }
}

output "application_security_group_info" {
  value = azurerm_application_security_group.dev_rg_sec_group.name
}

output "network_security_group_info" {
  value = {
    name = azurerm_network_security_group.dev_rg_net_sec_group.name
    id   = azurerm_network_security_group.dev_rg_net_sec_group.id
  }
}

