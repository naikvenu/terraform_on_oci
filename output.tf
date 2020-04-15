output "terraform_bastion" {
  value = module.oci_instances.instance.terraform_bastion.public_ip
}

output "terraform_host" {
  value = module.oci_instances.instance.terraform_host.private_ip
}

output "terraform_etcd" {
  value = module.oci_instances.instance.terraform_etcd.private_ip
}