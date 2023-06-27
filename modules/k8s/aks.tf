variable "clusters" {
  type    = map(object({
    name         = string
    pool         = string
    region       = string
    max_pods     = number
    master_ipv4  = string
    machine_type = string
    node_count   = number
    resource_name = string
  }))
}

resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  for_each = var.clusters

  name                = each.value.name
  location            = each.value.region
  resource_group_name = each.value.resource_name
  dns_prefix          = each.value.name

  default_node_pool {
    name                 = each.value.pool
    node_count           = each.value.node_count
    vm_size              = each.value.machine_type
    max_pods             = each.value.max_pods
  }

  network_profile {
    network_plugin = "azure"
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    environment = "dev"
  }
}
