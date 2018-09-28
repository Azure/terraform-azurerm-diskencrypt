output "virtual_id" {
  description = "The id of the disk encryption VM extension applied."
  value       = "${concat(azurerm_virtual_machine_extension.vmextensionlinux.*.id,azurerm_virtual_machine_extension.vmextension.*.id)}"
}
