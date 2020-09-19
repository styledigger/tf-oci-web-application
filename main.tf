module network {
  source = "./modules/network"

  network          = var.network
  image_id         = var.image_id[var.region]
  compartment_ocid = var.compartment_ocid
  tenancy_ocid     = var.tenancy_ocid
}

module webserver {
  source = "./modules/webserver"

  webserver        = var.webserver
  image_id         = var.image_id[var.region]
  vcn_id           = module.network.vcn_id
  subnet_id        = module.network.public_subnet_id
  nsg_ids          = [module.network.nsg_ids["ssh"], module.network.nsg_ids["web"]]
  compartment_ocid = var.compartment_ocid
  tenancy_ocid     = var.tenancy_ocid
  private_key_path = var.private_key_path
}

module database {
  source = "./modules/database"

  database          = var.database
  db_admin_password = var.db_admin_password
  subnet_id         = module.network.private_subnet_id
  nsg_ids           = [module.network.nsg_ids["ssh"], module.network.nsg_ids["db"]]
  compartment_ocid  = var.compartment_ocid
  tenancy_ocid      = var.tenancy_ocid
}

output Webserver {
  value       = "http://${module.webserver.public_ip}/"
  description = "Webserver URL"
}

output Bastion_IP {
  value       = module.network.bastion_ip
  description = "Bastion server public IP"
}

output DB_Connect {
  value       = module.database.db_connect_string
  description = "Database connect string"
}
