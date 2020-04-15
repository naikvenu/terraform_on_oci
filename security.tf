// Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.

# Network Security

locals {
  tcp_protocol  = "6"
  all_protocols = "all"
}

module "oci_network_security" {
  source = "github.com/oracle-terraform-modules/terraform-oci-tdf-network-security"
  #source          = "oracle-terraform-modules/default-vcn/oci"

  default_compartment_id = var.compartment_id
  vcn_id                 = module.oci_network.vcn.id

  security_lists = {
    
    ssh_secrule_pub = {
      compartment_id = null
      defined_tags   = null
      freeform_tags  = null
      ingress_rules = [
        {
          stateless = false
          protocol  = local.tcp_protocol
          src       = local.anywhere
          src_type  = "CIDR_BLOCK"
          src_port  = null
          dst_port = {
            min = 22
            max = 22
          }
          icmp_type = null
          icmp_code = null
        },
      ]
      egress_rules = [
        {
          stateless = false
          protocol  = local.all_protocols
          dst       = local.anywhere
          dst_type  = "CIDR_BLOCK"
          src_port  = null
          dst_port  = null
          icmp_type = null
          icmp_code = null
        },
      ]
    },

    private = {
      compartment_id = null
      defined_tags   = null
      freeform_tags  = null
      ingress_rules = [
        {
          stateless = false
          protocol  = local.tcp_protocol
          src       = local.anywhere
          src_type  = "CIDR_BLOCK"
          src_port  = null
          dst_port = {
            min = 22
            max = 22
          }
          icmp_type = null
          icmp_code = null
        },
        {
          stateless = false
          protocol  = local.tcp_protocol
          src       = local.anywhere
          src_type  = "CIDR_BLOCK"
          src_port  = null
          dst_port = {
            min = 2379
            max = 2379  #For etcd 
          }
          icmp_type = null
          icmp_code = null
        },
      ]
      egress_rules = [
        {
          stateless = false
          protocol  = local.all_protocols
          dst       = local.anywhere
          dst_type  = "CIDR_BLOCK"
          src_port  = null
          dst_port  = null
          icmp_type = null
          icmp_code = null
        },
      ]
    }

    
  }
    

}