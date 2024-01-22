data "aws_s3_bucket" "hosting_bucket" {
  bucket = var.bucket_name
}