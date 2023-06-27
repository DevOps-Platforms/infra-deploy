provider "azurerm" {
  features {}
}

module "k8s" {
  source   = "./modules/k8s"
  clusters = var.clusters

  client_id     = var.client_id
  client_secret = var.client_secret
}

variable "clusters" {
  type = map(object({
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

variable "client_id" {
  description = "Azure Service Principal Client ID"
}

variable "client_secret" {
  description = "Azure Service Principal Client Secret"
}
