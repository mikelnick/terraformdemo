provider "aws" {
  alias = "s3bucket"
  region = "${var.region}"
  access_key = "${var.admin_access_key}"
  secret_key = "${var.admin_secret_key}"
}

# POLICY
resource "aws_iam_policy" "policy" {
    provider = "aws.s3bucket"
    name = "${var.new_policy}"
    path = "/"
    description = "${var.new_policy_desc}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowGroupToSeeBucketListInTheConsole",
            "Action": [
                "s3:ListAllMyBuckets",
                "s3:ListBucket",
                "s3:GetBucketLocation",
                "s3:ListBucketMultipartUploads"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::*"
            ]
        },
        {
            "Sid": "AllowAllS3ActionsBucket",
            "Action": [
                "s3:*"
            ],
            "Effect": "Allow",
            "Resource": [
                "${var.s3_bucket_resource}"
            ]
        }
    ]
}
EOF
}