variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "content_security_policy" {
  type        = string
  default     = "frame-ancestors 'none'; default-src 'none'; img-src 'self' data: https:; script-src 'self'; script-src-elem 'self' 'unsafe-inline' use.typekit.net www.google-analytics.com www.googletagmanager.com; connect-src *.google-analytics.com *.doubleclick.net; style-src 'self' 'unsafe-inline'; font-src 'self' use.typekit.net; object-src 'none'; frame-src *.youtube.com youtube.com *.google.com google.com"
  description = "The policy directives and their values that CloudFront includes as values for the Content-Security-Policy HTTP response header."
}