resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "k8s" {
  location            = azurerm_resource_group.rg.location
  name                = "k8s"
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "dns"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.node_count
  }
  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}

resource "azurerm_log_analytics_workspace" "main" {
    name                = "${var.log_analytics_workspace_name}-k8-analytics01"
    location            = var.log_analytics_workspace_location
    resource_group_name = "petclinic-k8s"
    sku                 = var.log_analytics_workspace_sku
}
resource "azurerm_log_analytics_solution" "main" {
    solution_name         = "ContainerInsights"
    location              = azurerm_log_analytics_workspace.main.location
    resource_group_name   = "petclinic-k8s"
    workspace_resource_id = azurerm_log_analytics_workspace.main.id
    workspace_name        = azurerm_log_analytics_workspace.main.name
    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}
