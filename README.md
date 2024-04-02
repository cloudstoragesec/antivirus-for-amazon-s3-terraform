# Important Notice: This Repository is Deprecated

This repository is now deprecated as the application has been transitioned into a Terraform module published on the [HashiCorp Registry](https://registry.terraform.io/modules/cloudstoragesec/cloud-storage-security/aws/latest). The new repository is available [here](https://github.com/cloudstoragesec/terraform-aws-cloud-storage-security).

To assist users who haven't migrated yet and facilitate the migration process, you'll find a [`moved_resources.tf`](moved_resources.tf) file, containing `moved {}` blocks to simplify the migration to the new module.

## How to Migrate

* **Update Your Terraform Configuration**: 
  * Modify your Terraform configuration files to use the Cloud Storage Security Terraform Module. (Example Below)
    * Make sure to use version `v1.0.0+css7.07.000` for the upgrade, as it includes essential updates for application-side AppConfig migration.
* **Copy the `moved_resources.tf` File**: 
  * Copy moved_resources.tf to the same location as the TF files from antivirus-for-amazon-s3-terraform module
  * If your Cloud Storage Security module has a different name, update the `to` paths in the `moved {}` blocks accordingly. `moved_resources.tf` assumes that the Cloud Storage Security module is named "cloud-storage-security".
* ** Delete dld resources:
  * Delete all TF files from antivirus-for-amazon-s3-terraform module except for moved_resources.tf
* **Initialize the new Module**: Run `terraform init`.
* **Check Terraform Plan**: Run `terraform plan`.
  * If you have a standard deployment it should have "Plan: 4 to add, 3 to change, 3 to destroy." and the rest of existing resources will say they have moved. __Make sure you see `moved` resources during terraform plan__
* **Apply Changes**: Execute `terraform apply` to implement the changes. 
  * You might get a Error: creating SSM Document (CloudStorageSecConfig-Schema-xxx): DocumentAlreadyExists due to deletion/re-creation timing.
    If that happens it will resolve itself on a re-apply
* After the CSS console is confirmed to be running (UI is loading), moved_resources.tf can be removed feel free to delete `moved_resources.tf` since the resources have been migrated to new state.

### Usage Example
```hcl
module "cloud-storage-security" {
  source       = "cloudstoragesec/cloud-storage-security/aws"
  version      = "1.0.0+css7.07.000"
  cidr         = "0.0.0.0/0"
  email        = "admin@example.com"
  subnet_a_id  = "subnet-aaa"
  subnet_b_id  = "subnet-bbb"
  vpc          = "vpc-xxx"
}
```