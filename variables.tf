# Network module input parameters, initialized in terraform.tfvars
variable network {}

# Webserver module input parameters, initialized in terraform.tfvars
variable webserver {}
variable image_id {
  type = map
  default = {
    // See https://docs.cloud.oracle.com/iaas/images/
    // Oracle-provided image "Oracle-Linux-8.2-2020.08.27-0"
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaack6wlu7smv5rrk3lofsmzgnc2a42isfchpui555lewm2irlaj6gq"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaanu3i6pwzymsvc5xelxlr2hy2ng7maqg4q7vwp5pr6obv2blyta7q"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa7tpqkexxldw2jc5xdu24f6rsgtv4femioc4iibcqpdpgzf2egfpa"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaattlrrstelpdotpotqqvvxsnkwrezud2kwgcktprpst4qds4o2jlq"
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
