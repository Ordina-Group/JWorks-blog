variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "content_security_policy" {
  type        = string
  default     = "frame-ancestors 'none'; default-src 'none'; img-src 'self'; script-src 'self'; script-src-elem 'self' 'unsafe-hashes'; font-src 'self'; object-src 'none';"
  description = "The policy directives and their values that CloudFront includes as values for the Content-Security-Policy HTTP response header."
}