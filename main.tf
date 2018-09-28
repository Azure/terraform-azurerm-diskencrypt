resource "random_string" "password" {
  length  = 16
  special = false
}

data "azurerm_resource_group" "test" {
  name = "${var.resource_group_name}"
}

data "azurerm_key_vault" "keyvault" {
  name                = "${var.key_vault_name}"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_virtual_machine_extension" "vmextension" {
  count                      = "${lower(var.vm_os_type) == "windows" ? 1 : 0}"
  name                       = "${random_string.password.result}"
  location                   = "${data.azurerm_resource_group.test.location}"
  resource_group_name        = "${data.azurerm_resource_group.test.name}"
  virtual_machine_name       = "${var.vm_name}"
  publisher                  = "Microsoft.Azure.Security"
  type                       = "AzureDiskEncryption"
  type_handler_version       = "${var.type_handler_version == "" ? "2.2" : var.type_handler_version}"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
        "EncryptionOperation": "${var.encrypt_operation}",
        "KeyVaultURL": "${data.azurerm_key_vault.keyvault.vault_uri}",
        "KeyVaultResourceId": "${data.azurerm_key_vault.keyvault.id}",					
        "KeyEncryptionKeyURL": "${var.encryption_key_url}",
        "KekVaultResourceId": "${data.azurerm_key_vault.keyvault.id}",					
        "KeyEncryptionAlgorithm": "${var.encryption_algorithm}",
        "VolumeType": "${var.volume_type}"
    }
SETTINGS

  tags = "${var.tags}"
}

resource "azurerm_virtual_machine_extension" "vmextensionlinux" {
  count                      = "${lower(var.vm_os_type) == "linux" ? 1 : 0}"
  name                       = "${random_string.password.result}"
  location                   = "${data.azurerm_resource_group.test.location}"
  resource_group_name        = "${data.azurerm_resource_group.test.name}"
  virtual_machine_name       = "${var.vm_name}"
  publisher                  = "Microsoft.Azure.Security"
  type                       = "AzureDiskEncryptionForLinux"
  type_handler_version       = "${var.type_handler_version == "" ? "1.1" : var.type_handler_version}" 
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
        "EncryptionOperation": "${var.encrypt_operation}",
        "KeyVaultURL": "${data.azurerm_key_vault.keyvault.vault_uri}",
        "KeyVaultResourceId": "${data.azurerm_key_vault.keyvault.id}",					
        "KeyEncryptionKeyURL": "${var.encryption_key_url}",
        "KekVaultResourceId": "${data.azurerm_key_vault.keyvault.id}",					
        "KeyEncryptionAlgorithm": "${var.encryption_algorithm}",
        "VolumeType": "${var.volume_type}"
    }
SETTINGS

  tags = "${var.tags}"
}
