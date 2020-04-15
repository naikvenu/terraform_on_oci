##############################################
# Instances variable has a list of instances you want create
#   availability_domain is required, but null will assign the first AD of the region to the instance.
#   compartment_id      is required
#   shape               is required
#   subnet_id           is required
#   source_id           is required
#   All other attributes can be null
##############################################
locals {
  instances = {
        terraform_bastion = {
            ad                          = null #0-AD1, 1-AD2, 3-AD3 Required
            compartment_id              = var.compartment_id #Required
            shape                       = "VM.Standard2.1"                                                                      #Required
            subnet_id                   = module.oci_subnets.subnets.public.id
            
            is_monitoring_disabled      = null
            
            assign_public_ip            = true
            vnic_defined_tags           = null 
            vnic_display_name           = null
            vnic_freeform_tags          = null #{"Environment" = "Development"}
            nsg_ids                     = null #["ocid1.xxxxx"]
            private_ip                  = null
            skip_src_dest_check         = null

            defined_tags                = null 
            extended_metadata           = null
            fault_domain                = null
            freeform_tags               = null 
            hostname_label              = null
            ipxe_script                 = null
            pv_encr_trans_enabled       = null

            ssh_authorized_keys         = [var.public_key]     #ex: ["/path/public-key.pub"]
            ssh_private_keys            = [var.private_key]    #ex: ["/path/private-key"]
            bastion_ip                  = null
            user_data                   = null #base64encode(file("bootstrap.sh"))

            // See https://docs.cloud.oracle.com/iaas/images/
            // Oracle-provided image "Oracle-Linux-7.7-2019.06.15-0"
            image_name                  = "Canonical-Ubuntu-18.04-2020.02.18-0"  #Required
            source_id                   = null #"ocid1.image.oc1.eu-frankfurt-1.xxxxxx" #"ocid1.image.oc1.iad.xxxx"  #Required
            source_type                 = null
            boot_vol_size_gbs           = null
            kms_key_id                  = null
            mkp_image_name              = null
            mkp_image_name_version      = null

            preserve_boot_volume        = null
            instance_timeout            = null
            sec_vnics                   = null #{} #
            mount_blk_vols              = false
            block_volumes               = null
            cons_conn_create            = null
            cons_conn_def_tags          = null
            cons_conn_free_tags         = null

        },
        terraform_host = {
            ad                          = null #0-AD1, 1-AD2, 3-AD3 Required
            compartment_id              = var.compartment_id #Required
            shape                       = "VM.Standard2.1"                                                                      #Required
            subnet_id                   = module.oci_subnets.subnets.private.id
            
            is_monitoring_disabled      = null
            
            assign_public_ip            = false
            vnic_defined_tags           = null 
            vnic_display_name           = null
            vnic_freeform_tags          = null #{"Environment" = "Development"}
            nsg_ids                     = null #["ocid1.xxxxx"]
            private_ip                  = null
            skip_src_dest_check         = null

            defined_tags                = null 
            extended_metadata           = null
            fault_domain                = null
            freeform_tags               = null 
            hostname_label              = null
            ipxe_script                 = null
            pv_encr_trans_enabled       = null

            ssh_authorized_keys         = [var.public_key]     #ex: ["/path/public-key.pub"]
            ssh_private_keys            = [var.private_key]    #ex: ["/path/private-key"]
            bastion_ip                  = null
            user_data                   = null #base64encode(file("bootstrap.sh"))

            // See https://docs.cloud.oracle.com/iaas/images/
            // Oracle-provided image "Oracle-Linux-7.7-2019.06.15-0"
            image_name                  = "Canonical-Ubuntu-18.04-2020.02.18-0"  #Required
            source_id                   = null #"ocid1.image.oc1.eu-frankfurt-1.xxxxxx" #"ocid1.image.oc1.iad.xxxx"  #Required
            source_type                 = null
            boot_vol_size_gbs           = null
            kms_key_id                  = null
            mkp_image_name              = null
            mkp_image_name_version      = null

            preserve_boot_volume        = null
            instance_timeout            = null
            sec_vnics                   = null #{} #
            mount_blk_vols              = false
            block_volumes               = null
            cons_conn_create            = null
            cons_conn_def_tags          = null
            cons_conn_free_tags         = null

        },
        terraform_etcd = {
            ad                          = null #0-AD1, 1-AD2, 3-AD3 Required
            compartment_id              = var.compartment_id #Required
            shape                       = "VM.Standard2.1"                                                                      #Required
            subnet_id                   = module.oci_subnets.subnets.private.id
            
            is_monitoring_disabled      = null
            
            assign_public_ip            = false
            vnic_defined_tags           = null 
            vnic_display_name           = null
            vnic_freeform_tags          = null #{"Environment" = "Development"}
            nsg_ids                     = null #["ocid1.xxxxx"]
            private_ip                  = null
            skip_src_dest_check         = null

            defined_tags                = null 
            extended_metadata           = null
            fault_domain                = null
            freeform_tags               = null 
            hostname_label              = null
            ipxe_script                 = null
            pv_encr_trans_enabled       = null

            ssh_authorized_keys         = [var.public_key]     #ex: ["/path/public-key.pub"]
            ssh_private_keys            = [var.private_key]    #ex: ["/path/private-key"]
            bastion_ip                  = null
            user_data                   = null #base64encode(file("bootstrap.sh"))

            // See https://docs.cloud.oracle.com/iaas/images/
            // Oracle-provided image "Oracle-Linux-7.7-2019.06.15-0"
            image_name                  = "Canonical-Ubuntu-18.04-2020.02.18-0"  #Required
            source_id                   = null #"ocid1.image.oc1.eu-frankfurt-1.xxxxxx" #"ocid1.image.oc1.iad.xxxx"  #Required
            source_type                 = null
            boot_vol_size_gbs           = null
            kms_key_id                  = null
            mkp_image_name              = null
            mkp_image_name_version      = null

            preserve_boot_volume        = null
            instance_timeout            = null
            sec_vnics                   = null #{} #
            mount_blk_vols              = false
            block_volumes               = null
            cons_conn_create            = null
            cons_conn_def_tags          = null
            cons_conn_free_tags         = null

        }
  }
  create_compute = true
}

module "oci_instances" {
  source                  = "github.com/oracle-terraform-modules/terraform-oci-tdf-compute-instance"
  default_compartment_id  = var.compartment_id
  instances = local.create_compute ? local.instances : null
}