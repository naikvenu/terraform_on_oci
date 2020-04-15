provider "oci" {
  tenancy_ocid     = "${var.tenancy_id}"
  user_ocid        = "${var.user_id}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region           = "${var.region}"
}

terraform {
  backend "s3" {
    bucket   = "terraform-test"
    key      = "terraform.tfstate"
    region   = "ap-sydney-1"
    endpoint = "https://ociateam.compat.objectstorage.ap-sydney-1.oraclecloud.com"
    

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_get_ec2_platforms      = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}