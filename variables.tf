# Network module input parameters, initialized in terraform.tfvars
variable network {}

# Webserver module input parameters, initialized in terraform.tfvars
variable webserver {}
variable image_id {
  type = map
  default = {
    // See https://docs.cloud.oracle.com/iaas/images/
    // Oracle-provided image "Oracle-Linux-7.7-2020.01.28-0"
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaamff6sipozlita6555ypo5uyqo2udhjqwtrml2trogi6vnpgvet5q"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaamspvs3amw74gzpux4tmn6gx4okfbe3lbf5ukeheed6va67usq7qq"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa4xluwijh66fts4g42iw7gnixntcmns73ei3hwt2j7lihmswkrada"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaa2jxzt25jti6n64ks3hqbqbxlbkmvel6wew5dc2ms3hk3d3bdrdoa"
  }
}

# Database module input parameters, initialized in terraform.tfvars
variable database {}
variable db_admin_password {}

# Variables required by Oracle OCI provider, initiated by environment variables (tfenv.cmd) 
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}

provider "oci" {
  version          = ">= 3.0.0"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}
