provider "aws" {
  alias = "s3bucket"
  region = "${var.region}"
  access_key = "${var.admin_access_key}"
  secret_key = "${var.admin_secret_key}"
}

# S3
module "s3bucket" {
  region = "${var.region}"
  admin_access_key = "${var.admin_access_key}"
  admin_secret_key = "${var.admin_secret_key}"
  source     = "./module_create_s3_bucket"
  bucket_name = "${var.bucket_name}"
  admin_account_id = "${var.admin_account_id}"
}

# POLICY
module "s3policy" {
  region = "${var.region}"
  admin_access_key = "${var.admin_access_key}"
  admin_secret_key = "${var.admin_secret_key}"
  source     = "./module_create_s3_policy"
  new_policy = "${var.new_policy}"
  new_policy_desc = "${var.new_policy_desc}"
  s3_bucket_resource = "${var.s3_bucket_resource}"
}

resource "aws_iam_user" "user" {
    provider = "aws.s3bucket"
    name = "${var.s3user}"
    path = "/"
}

resource "aws_iam_policy_attachment" "s3bucket" {
    provider = "aws.s3bucket"
    name = "${var.new_policy}"
    users = ["${var.s3user}"]
    policy_arn = "${module.s3policy.arn}"
}
