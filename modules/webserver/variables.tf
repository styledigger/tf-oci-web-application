variable webserver {}
variable compartment_ocid {}
variable tenancy_ocid {}
variable image_id {}
variable vcn_id {}
variable subnet_id {}
variable nsg_ids {}
variable private_key_path {}

output public_ip {
  value       = oci_core_instance.webserver.public_ip
  description = "Webserver public IP address"
}

/* Uncomment if you want to use this module standalone

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}


provider "oci" {
  version          = ">= 3.0.0"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}
*/
