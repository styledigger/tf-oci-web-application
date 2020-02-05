variable network {}
variable compartment_ocid {}
variable tenancy_ocid {}
variable image_id {}

output vcn_id {
  value       = oci_core_vcn.vcn.id
  description = "Public subnet OCID"
}

output public_subnet_id {
  value       = oci_core_subnet.sub_public.id
  description = "Public subnet OCID"
}

output private_subnet_id {
  value       = oci_core_subnet.sub_private.id
  description = "Private subnet OCID"
}

output nsg_ids {
  value = {
    ssh = oci_core_network_security_group.nsg_ssh.id
    web = oci_core_network_security_group.nsg_http.id
    db  = oci_core_network_security_group.nsg_database.id
  }
  description = "Network Security group IDs"
}

output bastion_ip {
  value       = var.network.create_bastion ? oci_core_instance.bastion[0].public_ip : "None"
  description = "Bastion server public IP address"
}

/* Uncomment if you want to use this module standalone

variable "tenancy_ocid" {}
variable "region" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}

provider "oci" {
  version          = ">= 3.0.0"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}
*/
