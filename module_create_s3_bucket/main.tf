provider "aws" {
  alias = "s3bucket"
  region = "${var.region}"
  access_key = "${var.admin_access_key}"
  secret_key = "${var.admin_secret_key}"
}

resource "aws_s3_bucket" "bucket" {
  provider = "aws.s3bucket"
  bucket = "${var.bucket_name}"
  acl    = "private"

  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "AllowTest",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.admin_account_id}:root"
      },
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::${var.bucket_name}/*"
    }
  ]
}
POLICY
}