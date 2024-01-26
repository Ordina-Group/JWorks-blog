module "s3_static_hosting" {
  source                       = "github.com/Ordina-Group/jworks-aws-infra.git//landing-zones/static-website?ref=d51b02e88610af84a7de0a7a113bd798741834b1"
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
  web_acl_id                   = module.waf.web_acl_arn
}

module "waf" {
  source            = "github.com/Ordina-Group/jworks-aws-infra.git//waf-module?ref=8ac9e2e5b93b740c82fae06ad0e810eb454470a2"
  project_name      = "waf-jworks-tech-blog"
  cloudfront        = true
  blocked_countries = ["RU", "GB", "FR"]
}


#module "s3_uploader" {
#  source                = "../../modules/s3-uploader"
#  bucket_name           = module.s3_static_hosting.bucket_name
#  source_file_directory = "../../../blog"
#  depends_on            = [module.s3_static_hosting]
#}