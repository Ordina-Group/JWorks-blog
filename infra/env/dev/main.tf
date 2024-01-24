module "s3_static_hosting" {
  source                       = "github.com/Ordina-Group/jworks-aws-infra.git//landing-zones/static-website?ref=101920bb82ffb7819e49604a8ed11ba85df5ba00"
  app_name                     = "blog"
  bucket_name                  = "blog.ordina-jworks.io"
  region                       = var.aws_region
  root_domain_name             = "tst.ordina-jworks.io"
  access_control_allow_headers = ["blog"]
  access_control_allow_methods = ["GET"]
  access_control_allow_origins = ["https://blog.tst.ordina-jworks.io"]
  content_security_policy      = var.content_security_policy
  cross_origin_embedder_policy = "unsafe-none"
  cross_origin_opener_policy   = "unsafe-none"
  cross_origin_resource_policy = "unsafe-none"
}

#module "s3_uploader" {
#  source                = "../../modules/s3-uploader"
#  bucket_name           = module.s3_static_hosting.bucket_name
#  source_file_directory = "../../../blog"
#  depends_on            = [module.s3_static_hosting]
#}