# 🚀 Terraform Modules for AKS and Azure Infrastructure

This repository contains reusable **Terraform modules** for deploying and managing **Azure Kubernetes Service (AKS)** clusters, along with supporting resources like networking, storage, monitoring, and identity management.  
Each module is designed to be **modular, composable, and production-ready**.

---

## 📂 Modules Overview

| Module Name                  | Description |
|------------------------------|-------------|
| **resource_group**           | Creates the Reesource Group |
| **vnet**                     | Creates Virtual Network (VNet) and subnets for AKS and related services. public/private subnets and also capability to associate the private subnet with nat gateway |
| **public_ip**                | Creates the Public IPs to use for public resources |
| **nsg**                      | Creates the Network Security Groups with Rules and associates with subnet to defined inbound and outbound traffic |
| **linux_vm**                 | Creates the Virtual Machines with NIC for Linux based Operating Systems |
| **windows_vm**                 | Creates the Virtual Machines with NIC for Windows based Operating Systems |
| **read-keyvault-secrets**    | Reads the mentioned secrets keys from Azure Key Vault. For example for admin user of virtual machine | 
| **managed-disk**             | Creates and attaches the Azure Managed Disks to the virtual machines |
| **aks_cluster**              | Provisions an AKS cluster with configurable node pools, authentication, and networking. |
| **aks_nodepool**             | Provisions an AKS cluster with configurable node pools, authentication, and networking. |

---

## 📌 Prerequisites

Before using these modules, ensure you have:

- **Terraform v1.3+**
- **Azure CLI**
- An Azure subscription with sufficient permissions.
- Proper authentication set up (Azure CLI logged in or service principal credentials).

---

## 🛠️ Usage

You can combine modules in a **root Terraform configuration** like this:

```hcl
provider "azurerm" {
  features {}
}

module "rg" {
  source = "./modules/resource_group"
	resource_group_name = var.resource_group_name
	location = var.location
}


module "test_vnet" {
  source              =   "./modules/vnet"
  resource_group_name =   module.rg.resource_group_name
  location            =   var.location
  vnet_name           =   var.vnet_details.name
  address_space       =   var.vnet_details.address_space_cidr
  subnets             =   var.subnets
}

module "secrets" {
  source                  = "./modules/read-keyvault-secrets"
  key_vault_name          = var.secrets_keyvault_name
  key_vault_resource_group = var.secrets_keyvault_rg
  secret_names            = var.secrets_to_read
}

module "jumpserver_public_ip" {
  source = "./modules/public_ip"
  name = "jumpbox-public-ip"
  location = var.location
  resource_group_name = module.rg.resource_group_name
  allocation_method = "Static"
  sku = "Standard"
  sku_tier = "Regional"
}

module "example-datadisk1" {
  source = "./modules/managed-disk"
  name                 = "${var.example.name}-1"
  location             = var.location
  resource_group_name  = module.rg.resource_group_name
  storage_account_type = var.example.storage_account_type
  create_option        = var.example.create_option
  disk_size_gb         = var.example.disk_size_gb
  virtual_machine_id   = module.linux_vms["example-vm1"].vm_id
  lun                  = var.example.lun
  caching              = var.example.caching
}

module "private_service_nsg" {
  source = "./modules/nsg"
  nsg_name = "${lookup(var.isolated_nsg,"name")}"
  location = "${lookup(var.isolated_nsg,"location")}"
  resource_group_name = module.rg.resource_group_name
  security_rules = "${lookup(var.isolated_nsg,"rules")}"
  subnet_id = module.test_vnet.subnet_ids["private1"]
}

module "aks_cluster" {
  source = "./modules/aks_cluster"

  name                = "myAKSCluster"
  location            = "eastus"
  resource_group_name = "myResourceGroup"
  dns_prefix          = "myaks"

  kubernetes_version  = "1.29.2"
  private_cluster_enabled = true
  authorized_ip_ranges    = ["1.2.3.4/32"]

  default_node_pool_name                = "default"
  default_node_pool_vm_size             = "Standard_DS2_v2"
  default_node_pool_node_count          = 5
  default_node_pool_os_disk_size_gb     = 50
  default_node_pool_type                = "VirtualMachineScaleSets"
  default_node_pool_zones               = ["1", "2"]
  default_node_pool_enable_auto_scaling = true
  default_node_pool_min_count           = 1
  default_node_pool_max_count           = 3

  identity_type = "SystemAssigned"

  network_plugin     = "kubenet"
  network_policy     = "azure"
  service_cidr       = "10.1.0.0/16"
  dns_service_ip     = "10.1.0.10"
  outbound_type      = "loadBalancer"

  rbac_enabled       = true
  admin_group_object_ids = []

  log_analytics_workspace_id     = "/subscriptions/<sub_id>/resourceGroups/<rg>/providers/Microsoft.OperationalInsights/workspaces/<workspace_name>"
  http_application_routing_enabled = false
  azure_policy_enabled           = false

  vnet_subnet_id = module.test_vnet.subnet_ids["private1"]

  tags = {
    Environment = "Dev"
    Project     = "TerraformAKS"
  }
}

module "dnsserver-vm1" {
  source = "./modules/linux-vm"
  admin_ssh_key = module.secrets.secrets["vm-public-key"]
  admin_username = module.secrets.secrets["vm-username"]
  name = "dnsserver-vm-1"
  location = "eastus"
  resource_group_name = module.on_prem_rg.resource_group_name
  dns_servers = ["192.168.0.100"]
  enable_accelerated_networking = true
  subnet_id = module.vnet.subnet_ids["public1"]
  public_ip_ids = [module.dns_server_public_ip.public_ip_address]
  vm_size = "Standard_D2s_v5"
  priority = "Regular"
  max_bid_price = "-1"
  eviction_policy = null
  custom_data_file  = templatefile("./scripts/custom_script_ubuntu.sh.tmpl", {
  lab_domain_name = var.lab_domain_name
  })


  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 64
  }

  image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  #network_security_group_id = module.test_nsg.nsg_id
  associate_nsg             = false
  tags = {}
}


module "jumpserver-vm1" {
  source = "./modules/windows-vm"
  name = "jumpserver-vm-1"
  location = var.location
  resource_group_name = module.rg.resource_group_name
  dns_servers = ["192.168.0.100"]
  enable_accelerated_networking = true
  subnet_id = module.on_prem_vnet.subnet_ids["public1"]
  public_ip_ids = [module.jumpserver_public_ip.public_ip_address]

  vm_size = "Standard_D4ds_v5"
  admin_username = module.secrets.secrets["vm-username"]
  admin_password = module.secrets.secrets["vm-password"]
  priority = "Regular"
  max_bid_price = "-1"
  eviction_policy = null
  custom_data_file = null

  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 64
  }

  image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  associate_nsg             = false
  tags = {}
}


