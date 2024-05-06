resource "aws_s3_bucket" "addons" {
  bucket_prefix = var.name
}