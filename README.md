## This example will create the following resources on OCI (oracle cloud infrastructure)

```
1x VCN (with 1 internet gateway and 1 nat gateway)
2x subnets (public and private)
1x bastion host
1x terraform host
1x etcd host
```

## Using this example

Prepare one variable file named "terraform.tfvars" with the required information. The content of "terraform.tfvars" should look something like the following:


## Oracle Cloud Infrastructure Authentication details

```
$ cat terraform.tfvars
tenancy_id = "ocid1.tenancy.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
user_id = "ocid1.user.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
fingerprint= "xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx"
private_key_path = "~/.oci/oci_api_key.pem"
```

## Region

```
region = "us-phoenix-1"
```

## Compartment

```
compartment_id = "ocid1.compartment.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

## Then apply the example using the following commands:

```
$ terraform init
$ terraform plan
$ terraform apply
```
