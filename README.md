# 🚀 Terraform Modules for AKS and Azure Infrastructure

This repository contains reusable **Terraform modules** for deploying and managing **Azure Kubernetes Service (AKS)** clusters, along with supporting resources like networking, storage, monitoring, and identity management.  
Each module is designed to be **modular, composable, and production-ready**.

---

## 📂 Modules Overview

| Module Name           | Description |
|-----------------------|-------------|
| **aks_cluster**       | Provisions an AKS cluster with configurable node pools, authentication, and networking. |
| **vnet**              | Creates Virtual Network (VNet) and subnets for AKS and related services. |
| **acr**               | Deploys an Azure Container Registry for storing container images. |
| **monitoring**        | Configures Azure Monitor and log analytics integration for AKS. |
| **identity**          | Creates Azure Managed Identities for AKS and related services. |
| **network_security**  | Sets up Network Security Groups (NSG) and rules for AKS and subnets. |
| **dns_zone**          | Creates Azure DNS zones and records for AKS ingress endpoints. |
| **storage_account**   | Creates Azure Storage Accounts for persistent storage and logging. |

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

module "vnet" {
  source              = "./modules/vnet"
  name                = "aks-vnet"
  resource_group_name = "aks-rg"
  address_space       = ["10.0.0.0/8"]
  subnets = {
    aks     = ["10.240.0.0/16"]
    backend = ["10.241.0.0/16"]
  }
}

module "acr" {
  source              = "./modules/acr"
  name                = "aksacr"
  resource_group_name = "aks-rg"
  sku                 = "Standard"
}

module "aks_cluster" {
  source              = "./modules/aks_cluster"
  name                = "aks-prod"
  resource_group_name = "aks-rg"
  dns_prefix          = "aks"
  kubernetes_version  = "1.29.0"
  vnet_subnet_id      = module.vnet.subnet_ids["aks"]
  acr_id              = module.acr.id
  node_pools = [
    {
      name       = "system"
      vm_size    = "Standard_DS2_v2"
      node_count = 3
    }
  ]
}
