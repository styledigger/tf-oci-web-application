data oci_identity_availability_domains ad {
  compartment_id = var.tenancy_ocid
}

resource "oci_database_db_system" db_system {
  availability_domain = data.oci_identity_availability_domains.ad.availability_domains[var.database.ad_number].name
  compartment_id      = var.compartment_ocid
  database_edition    = var.database.db_edition

  db_home {
    db_version   = var.database.db_version
    display_name = var.database.db_home_display_name

    database {
      admin_password = var.db_admin_password
      db_name        = var.database.db_name
      pdb_name       = var.database.pdb_name
    }
  }

  hostname                = var.database.system_hostname
  shape                   = var.database.system_shape
  ssh_public_keys         = var.database.ssh_public_key
  subnet_id               = var.subnet_id
  data_storage_size_in_gb = var.database.data_storage_size_in_gb
  display_name            = var.database.db_system_display_name
  license_model           = var.database.license_model
  node_count              = var.database.node_count
  nsg_ids                 = var.nsg_ids
  source                  = "NONE"
}
