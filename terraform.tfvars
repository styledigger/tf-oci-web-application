network = {
  name               = "acme"
  cidr_block         = "10.0.0.0/16"
  cidr_block_public  = "10.0.0.0/24"
  cidr_block_private = "10.0.10.0/24"
  create_bastion     = "true"
  ssh_public_key     = "ssh-rsa AAAAB3N..."
}

webserver = {
  name             = "webserver"
  ad_number        = "1"              # 1 | 2 | 3
  shape            = "VM.Standard2.1" # https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm
  assign_public_ip = "true"
  hostname_label   = "webserver"
  ssh_public_key   = "ssh-rsa AAAAB3N..."
}

database = {
  db_name                 = "database"
  db_edition              = "STANDARD_EDITION" # STANDARD_EDITION | ENTERPRISE_EDITION | ENTERPRISE_EDITION_HIGH_PERFORMANCE | ENTERPRISE_EDITION_EXTREME_PERFORMANCE 
  pdb_name                = "pdb_1"
  ad_number               = "1"        # 1 | 2 | 3
  db_version              = "19.0.0.0" # oci db version list --compartment-id <compartment OCID>
  db_home_display_name    = "dbhome"
  system_hostname         = "dbhost"
  system_shape            = "VM.Standard2.1" # oci db system-shape list --compartment-id <compartment OCID>
  data_storage_size_in_gb = "256"            # [256, 512, 1024, 2048, 4096, 6144, 8192, 10240, 12288, 14336, 16384, 18432, 20480, 22528, 24576, 26624, 28672, 30720, 32768, 34816, 36864, 38912, 40960]
  db_system_display_name  = "Database"
  license_model           = "BRING_YOUR_OWN_LICENSE" # BRING_YOUR_OWN_LICENSE | LICENSE_INCLUDED
  node_count              = "1"
  ssh_public_key          = "ssh-rsa AAAAB3N..."
}
