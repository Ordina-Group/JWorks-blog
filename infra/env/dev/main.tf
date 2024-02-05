module "s3_static_hosting" {
  source                       = "github.com/Ordina-Group/jworks-terraform-modules.git//static-website?ref=53dd92ca1c4b439be0532bd0ed23e9dc4497515b"
  app_name                     = "blog"
  bucket_name                  = "blog.tst.ordina-jworks.io"
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
  source              = "github.com/Ordina-Group/jworks-terraform-modules.git//waf-module?ref=53dd92ca1c4b439be0532bd0ed23e9dc4497515b"
  project_name        = "waf-jworks-tech-blog"
  cloudfront          = true
  blocked_countries   = ["RU"]
  region              = "us-east-1"
  waf_rule_group_name = "waf-jworks-tech-blog-rule-group"
}