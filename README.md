## 📑 Module Documentation

Below are the **Inputs** and **Outputs** for each module.  
When using them, set `source = "./modules/<module_name>"` in your Terraform code.

---

### `aks_cluster`

**Inputs:**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `resource_group_name` | `string` | n/a | Resource group name |
| `cluster_name` | `string` | n/a | AKS Cluster name |
| `dns_prefix` | `string` | n/a | DNS prefix for AKS cluster |
| `kubernetes_version` | `string` | `"1.27.3"` | Kubernetes version |
| `network_plugin` | `string` | `"azure"` | Network plugin type |

**Outputs:**

| Name | Value | Description |
|------|-------|-------------|
| `aks_cluster_id` | `azurerm_kubernetes_cluster.aks.id` | The AKS cluster ID |
| `kube_config` | `azurerm_kubernetes_cluster.aks.kube_config_raw` | Raw kubeconfig for connecting |

---

### `vnet`

**Inputs:**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `resource_group_name` | `string` | n/a | Resource group name |
| `vnet_name` | `string` | n/a | Virtual Network name |
| `address_space` | `list(string)` | n/a | List of address spaces |

**Outputs:**

| Name | Value | Description |
|------|-------|-------------|
| `vnet_id` | `azurerm_virtual_network.vnet.id` | Virtual Network ID |

---

### `linux_vm`

**Inputs:**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `name` | `string` | n/a | VM name |
| `resource_group_name` | `string` | n/a | Resource group |
| `location` | `string` | `"eastus"` | Azure location |
| `admin_username` | `string` | `"azureuser"` | Admin username |
| `ssh_public_key` | `string` | n/a | SSH public key path |

**Outputs:**

| Name | Value | Description |
|------|-------|-------------|
| `vm_id` | `azurerm_linux_virtual_machine.vm.id` | Linux VM ID |

---

### `keyvault_reader`

**Inputs:**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `key_vault_name` | `string` | n/a | Name of the Key Vault |
| `object_id` | `string` | n/a | Object ID to grant access |

**Outputs:**

| Name | Value | Description |
|------|-------|-------------|
| `keyvault_id` | `azurerm_key_vault.kv.id` | Key Vault resource ID |

---

### `managed_disk`

**Inputs:**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `disk_name` | `string` | n/a | Managed Disk name |
| `disk_size_gb` | `number` | n/a | Disk size in GB |
| `resource_group_name` | `string` | n/a | Resource group |

**Outputs:**

| Name | Value | Description |
|------|-------|-------------|
| `disk_id` | `azurerm_managed_disk.disk.id` | Managed Disk ID |

---

### `network_interface`

**Inputs:**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `nic_name` | `string` | n/a | Network Interface Card name |
| `resource_group_name` | `string` | n/a | Resource group |
| `subnet_id` | `string` | n/a | Subnet ID |

**Outputs:**

| Name | Value | Description |
|------|-------|-------------|
| `nic_id` | `azurerm_network_interface.nic.id` | NIC ID |

---

### `network_security_group`

**Inputs:**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `nsg_name` | `string` | n/a | NSG name |
| `resource_group_name` | `string` | n/a | Resource group |

**Outputs:**

| Name | Value | Description |
|------|-------|-------------|
| `nsg_id` | `azurerm_network_security_group.nsg.id` | NSG ID |

---

### `public_ip`

**Inputs:**

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `public_ip_name` | `string` | n/a | Public IP name |
| `allocation_method` | `string` | `"Static"` | Allocation method |
| `resource_group_name` | `string` | n/a | Resource group |

**Outputs:**

| Name | Value | Description |
|------|-------|-------------|
| `public_ip_id` | `azurerm_public_ip.pip.id` | Public IP resource ID |
| `public_ip_address` | `azurerm_public_ip.pip.ip_address` | IP address value |
