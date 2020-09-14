variable database {}

variable db_admin_password {}
variable compartment_ocid {}
variable tenancy_ocid {}
variable subnet_id {}
variable nsg_ids {}

output db_connect_string {
  #  value       = oci_database_db_system.db_system[0].db_home[0].database[0].connection_strings[0].cdb_default
  value       = var.database.create_db ? oci_database_db_system.db_system[0].db_home[0].database[0].connection_strings[0].cdb_default : "None"
  description = "Database connect string"
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
