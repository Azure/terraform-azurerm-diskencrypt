output "virtual_id" {
  description = "The id of the disk encryption VM extension applied."
  value       = "${azurerm_virtual_machine_extension.vmextension.id}"
}
