# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

locals {
  next_hop_ids            = {
    
    "igw"                 = module.oci_network.igw.id
    "natgw"                 = module.oci_network.natgw.id
    //"svcgw"                 = module.oci_network.svcgw.id
    
  }
  dhcp_option_types       = {
    "vcn"                 = "VcnLocalPlusInternet"
    "custom"              = "CustomDnsServer"
  }

  anywhere = "0.0.0.0/0"
  vcn_cidr = "10.0.0.0/16"

  subnet_public_cidr  = "${cidrsubnet(local.vcn_cidr, 8, 0)}"
  subnet_private_cidr = "${cidrsubnet(local.vcn_cidr, 8, 1)}"
  //subnet_bastion_cidr = "${cidrsubnet(local.vcn_cidr, 8, 2)}"

}

module "oci_network" {
  source                  = "github.com/oracle-terraform-modules/terraform-oci-tdf-network"
  default_compartment_id  = var.compartment_id
  
  vcn_options             = {
    display_name          = "terraform_vcn"
    cidr                  = local.vcn_cidr
    enable_dns            = true
    dns_label             = "terraform"
    compartment_id        = null
    defined_tags          = null
    freeform_tags         = null
  }
  route_tables = {
      terraform_public_route = {
      compartment_id = null
      defined_tags   = null
      freeform_tags  = null
      route_rules = [
        {
          dst         = local.anywhere
          dst_type    = "CIDR_BLOCK"
          next_hop_id = local.next_hop_ids["igw"]
        }
      ]
    },
    
    terraform_natgw_route = {
      compartment_id = null
      defined_tags   = null
      freeform_tags  = null
      route_rules = [
        {
          dst         = local.anywhere
          dst_type    = "CIDR_BLOCK"
          next_hop_id = local.next_hop_ids["natgw"]
        }
      ]
    }
  }
  

  create_igw              = true
  create_svcgw            = false
  create_natgw            = true
  create_drg              = false 
}