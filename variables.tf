variable vm_name {
     description = "Name of the VM to encrypt"
     default = "ubuntu1"
}

variable "resource_group_name" {
  description = "Default resource group name that the network will be created in."
  default     = "vjresourcegroup"
}

variable "location" {
  description = "The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"
  default     = "South Central US"
}


variable key_vault_name {
    description = "Name of the keyVault"
    default = "testkeyVault123"
}

variable encryption_key_url {
    description = "URL to encrypt Key"
    default = ""
}

variable encryption_algorithm {
    description = " Algo for encryption"
    default = "RSA-OAEP"
}

variable "volume_type" {
    default = "All"
}

variable "encrypt_operation" {
    default = "EnableEncryption"

}

