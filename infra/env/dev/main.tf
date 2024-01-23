module "s3_static_hosting" {
  source                       = "github.com/Ordina-Group/jworks-aws-infra.git//landing-zones/static-website?ref=4acf7743ed3484ff0051f5cab32199a647ed8a53"
  app_name                     = "blog"
  bucket_name                  = "blog.ordina-jworks.io"
  region                       = var.aws_region
  root_domain_name             = "tst.ordina-jworks.io"
  access_control_allow_origins = ["https://blog.ordina-jworks.io"]

}

module "s3_uploader" {
  source                = "../../modules/s3-uploader"
  bucket_name           = module.s3_static_hosting.bucket_name
  source_file_directory = "../../../_site"
  depends_on            = [module.s3_static_hosting]
}