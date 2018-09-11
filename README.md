

## Encrypt an existing  Virtual Machine in Azure
This module implements Azure Disk Encryption feature to encrypt currently running VM's.  ADE leverages the industry standard BitLocker feature of Windows and DM-Crypt feature of lihnux to provide volume encryption for the OS and data disks.

## prerequisites
All the prerequsites can be found at the [Azure Disk Encryption prerequisites](https://docs.microsoft.com/en-us/azure/security/azure-security-disk-encryption-prerequisites)

**Setting the [Advanced access policies](https://docs.microsoft.com/en-us/azure/security/azure-security-disk-encryption-prerequisites#bkmk_KVper) for the Key Vault is required for this module to work.** 

## Usage


```hcl

module "diskencrypt" {
  source               = "Azure/diskencrypt/azurerm"
  resource_group_name  = "myapp"
  location             = "westus"
  vm_name              = "ubuntu1"
  key_vault_name       = "testkeyvault123"
  encryption_algorithm = "RSA-OAEP"
  encryption_key_url   = "https://testkeyVault123.vault.azure.net:443/keys/ContosoFirstKey/9465333262aa49468c7f0dad5a167ee8"
  
  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}

```

# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
