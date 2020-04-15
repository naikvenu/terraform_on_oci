# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

module "oci_subnets" {
  source           = "github.com/oracle-terraform-modules/terraform-oci-tdf-subnet/"
  
  default_compartment_id  = var.compartment_id
  # below can be uncomment if it is being read from remote_state.
  # vcn_id = data.terraform_remote_state.network.outputs.vcn.id
  vcn_id                = module.oci_network.vcn.id
  vcn_cidr              = module.oci_network.vcn.cidr_block
  
  subnets               = {
    public               = {
      compartment_id    = null
      defined_tags      = null
      freeform_tags     = null
      dynamic_cidr      = false
      cidr              = local.subnet_public_cidr
      cidr_len          = null
      cidr_num          = null
      enable_dns        = true
      dns_label         = "tpublicsubnet"
      private           = false
      ad                = null
      dhcp_options_id   = null
      route_table_id    = module.oci_network.route_tables.terraform_public_route.id
      security_list_ids = [module.oci_network_security.security_lists.ssh_secrule_pub.id]
    },
    private               = {
      compartment_id    = null
      defined_tags      = null
      freeform_tags     = null
      dynamic_cidr      = false
      cidr              = local.subnet_private_cidr
      cidr_len          = null
      cidr_num          = null
      enable_dns        = true
      dns_label         = "tprivatesubnet"
      private           = true
      ad                = null
      dhcp_options_id   = null
      route_table_id    = module.oci_network.route_tables.terraform_natgw_route.id
      security_list_ids = [module.oci_network_security.security_lists.private.id]
    }
    
}
}

