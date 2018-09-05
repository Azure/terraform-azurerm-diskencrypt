resource "random_string" "password" {
  length = 16
  special = false
}

resource "azurerm_resource_group" "test" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

data "azurerm_key_vault" "keyvault" {
  name                = "${var.keyVaultName}"
  resource_group_name = "${var.resource_group_name}"
}


resource "azurerm_virtual_machine_extension" "vmextension" {
  name                 = "${random_string.password.result}"
  location             = "${azurerm_resource_group.test.location}"
  resource_group_name  = "${azurerm_resource_group.test.name}"
  virtual_machine_name = "${var.vm_name}"
  publisher            = "Microsoft.Azure.Security"
  type                 = "AzureDiskEncryption"
  type_handler_version = "2.2"
  auto_upgrade_minor_version = true
  
  settings = <<SETTINGS
    {
        "EncryptionOperation": "${var.encrypt_operation}",
        "KeyVaultURL": "${data.azurerm_key_vault.keyvault.vault_uri}",
        "KeyVaultResourceId": "${data.azurerm_key_vault.keyvault.id}",					
        "KeyEncryptionKeyURL": "${var.keyEncryptionKeyURL}",
        "KekVaultResourceId": "${data.azurerm_key_vault.keyvault.id}",					
        "KeyEncryptionAlgorithm": "${var.encryption_algorithm}",
        "VolumeType": "${var.volume_type}"
    }
SETTINGS

  tags {
    environment = "Production"
  }
}