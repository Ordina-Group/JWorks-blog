resource "aws_s3_object" "files" {
  bucket = data.aws_s3_bucket.hosting_bucket.bucket

  for_each = fileset(var.source_file_directory, "**")
  key      = each.key

  source       = "${var.source_file_directory}/${each.value}"
  content_type = lookup(tomap(local.mime_types), element(split(".", each.key), length(split(".", each.key)) - 1))
  etag         = filemd5("${var.source_file_directory}/${each.value}")
}