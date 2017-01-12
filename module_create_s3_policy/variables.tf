# module_create_s3_policy vars
variable "new_policy" {}

variable "new_policy_desc" {}

variable "s3_bucket_resource" {}

variable "admin_access_key" {}

variable "admin_secret_key" {}

variable "region" {
  default = "us-east-1"
}