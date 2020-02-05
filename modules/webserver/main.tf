data oci_identity_availability_domains ad {
  compartment_id = var.tenancy_ocid
}

resource oci_core_instance webserver {
  display_name        = var.webserver.name
  availability_domain = data.oci_identity_availability_domains.ad.availability_domains[var.webserver.ad_number].name
  compartment_id      = var.compartment_ocid
  shape               = var.webserver.shape

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = var.webserver.assign_public_ip
    hostname_label   = var.webserver.hostname_label
    nsg_ids          = var.nsg_ids
  }

  metadata = {
    ssh_authorized_keys = var.webserver.ssh_public_key
    user_data           = base64encode(file("./nginx.sh"))
    # user_data = "${base64encode(file(var.custom_bootstrap_file_name))}"
  }

  source_details {
    source_id   = var.image_id
    source_type = "image"
  }

  preserve_boot_volume = false
}
