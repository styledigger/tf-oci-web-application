resource oci_core_vcn vcn {
  display_name   = "vcn-${var.network.name}"
  cidr_block     = var.network.cidr_block
  dns_label      = var.network.name
  compartment_id = var.compartment_ocid
} # vcn

resource oci_core_default_dhcp_options dhcp_default {
  display_name               = "DHCP - Default"
  manage_default_resource_id = oci_core_vcn.vcn.default_dhcp_options_id

  options {
    #    custom_dns_servers = []
    server_type = "VcnLocalPlusInternet"
    type        = "DomainNameServer"
  }

  options {
    type = "SearchDomain"
    search_domain_names = [
      "${var.network.name}.oraclevcn.com",
    ]
  }
} # DHCP-default

resource oci_core_default_route_table rt_internet {
  display_name               = "RT - Internet"
  manage_default_resource_id = oci_core_vcn.vcn.default_route_table_id

  route_rules {
    description       = "Internet Gateway"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.internet_gw.id
  }
} # rt_internet

resource oci_core_route_table rt_intranet {
  display_name   = "RT - Intranet"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id

  route_rules {
    description       = "NAT Gateway"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gw.id
  }

  route_rules {
    description       = "Service Gateway"
    destination       = "all-fra-services-in-oracle-services-network"
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.service_gw.id
  }
} # rt_intranet

resource oci_core_default_security_list sl_default {
  manage_default_resource_id = oci_core_vcn.vcn.default_security_list_id
  display_name               = "SL - Default"

  egress_security_rules {
    description      = "Allows all outbound traffic"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    stateless        = "false"
  }

  ingress_security_rules {
    description = "Path MTU Discovery fragmentation messages"
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    icmp_options {
      code = "4"
      type = "3"
    }
  }

  ingress_security_rules {
    description = "Allows to receive connectivity error messages from other instances within the vcn"
    protocol    = "1"
    source      = var.network.cidr_block
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    icmp_options {
      code = "-1"
      type = "3"
    }
  }
} # sl_default

resource oci_core_service_gateway service_gw {
  display_name   = "SGw-${var.network.name}"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  services {
    service_id = "ocid1.service.oc1.eu-frankfurt-1.aaaaaaaa7ncsqkj6lkz36dehifizupyn6qjqsmtepsegs23yyntnsy7qrvea"
  }
} # service_gw

resource oci_core_internet_gateway internet_gw {
  display_name   = "IGw-${var.network.name}"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  enabled        = "true"
} # internet_gw

resource oci_core_nat_gateway nat_gw {
  display_name   = "NATGw-${var.network.name}"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  block_traffic  = "false"
} # nat_gw

resource oci_core_network_security_group nsg_ssh {
  #Required
  display_name   = "SSH Access (port 22)"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
} # nsg_ssh

resource oci_core_network_security_group_security_rule nsg_ssh_rule {
  network_security_group_id = oci_core_network_security_group.nsg_ssh.id
  description               = "Allows inbound ssh connections to instance"
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  source_type               = "CIDR_BLOCK"
  source                    = "0.0.0.0/0"
  stateless                 = "false"

  tcp_options {
    destination_port_range {
      max = "22"
      min = "22"
    }
  }
} # NSG-ssh-rule

resource oci_core_network_security_group nsg_database {
  display_name   = "Database (port 1521)"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
} # nsg_database

resource oci_core_network_security_group_security_rule nsg_database_rule {
  network_security_group_id = oci_core_network_security_group.nsg_database.id
  description               = "Allows inbound connections from ${var.network.cidr_block} to database listener"
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  source_type               = "CIDR_BLOCK"
  source                    = var.network.cidr_block
  stateless                 = "false"

  tcp_options {
    destination_port_range {
      max = "1521"
      min = "1521"
    }
  }
} # nsg_database_rule

resource oci_core_network_security_group nsg_http {
  #Required
  display_name   = "HTTP/HTTPS (port 80, 443)"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
} # nsg_http

resource oci_core_network_security_group_security_rule nsg_http_rule_http {
  network_security_group_id = oci_core_network_security_group.nsg_http.id
  description               = "Allows inbound connections to http port 80"
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  source_type               = "CIDR_BLOCK"
  source                    = "0.0.0.0/0"
  stateless                 = "false"

  tcp_options {
    destination_port_range {
      max = "80"
      min = "80"
    }
  }
} # nsg_http_rule_http

resource oci_core_network_security_group_security_rule nsg_http_rule_https {
  network_security_group_id = oci_core_network_security_group.nsg_http.id
  description               = "Allows inbound connections to https port 443"
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  source_type               = "CIDR_BLOCK"
  source                    = "0.0.0.0/0"
  stateless                 = "false"

  tcp_options {
    destination_port_range {
      max = "443"
      min = "443"
    }
  }
} # nsg_http_rule_https

resource oci_core_subnet sub_public {
  display_name               = "Sub-Public-${var.network.name}"
  vcn_id                     = oci_core_vcn.vcn.id
  cidr_block                 = var.network.cidr_block_public
  compartment_id             = var.compartment_ocid
  dns_label                  = "public"
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_default_route_table.rt_internet.id

  security_list_ids = [
    oci_core_default_security_list.sl_default.id
  ]
} # sub_public

resource oci_core_subnet sub_private {
  display_name               = "Sub-Private-${var.network.name}"
  vcn_id                     = oci_core_vcn.vcn.id
  cidr_block                 = var.network.cidr_block_private
  compartment_id             = var.compartment_ocid
  dns_label                  = "private"
  prohibit_public_ip_on_vnic = "true"
  route_table_id             = oci_core_route_table.rt_intranet.id

  security_list_ids = [
    oci_core_default_security_list.sl_default.id
  ]
} # sub_private

data oci_identity_availability_domains ad {
  compartment_id = var.tenancy_ocid
}

resource oci_core_instance bastion {
  count               = var.network.create_bastion ? 1 : 0
  display_name        = "bastion"
  availability_domain = data.oci_identity_availability_domains.ad.availability_domains[2].name
  compartment_id      = var.compartment_ocid
  shape               = "VM.Standard.E2.1"

  create_vnic_details {
    subnet_id        = oci_core_subnet.sub_public.id
    assign_public_ip = "true"
    hostname_label   = "bastion"
    nsg_ids          = [oci_core_network_security_group.nsg_ssh.id]
  }

  metadata = {
    ssh_authorized_keys = var.network.ssh_public_key
  }

  source_details {
    source_id   = var.image_id
    source_type = "image"
  }

  preserve_boot_volume = false
}
