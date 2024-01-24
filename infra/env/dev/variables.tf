variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "content_security_policy" {
  type        = string
  default     = "frame-ancestors 'none'; default-src 'none'; img-src 'self'; script-src 'self'; script-src-elem 'self' use.typekit.net; style-src 'self' 'sha256-CwE3Bg0VYQOIdNAkbB/Btdkhul49qZuwgNCMPgNY5zw=' 'sha256-MZKTI0Eg1N13tshpFaVW65co/LeICXq4hyVx6GWVlK0=' 'sha256-LpfmXS+4ZtL2uPRZgkoR29Ghbxcfime/CsD/4w5VujE=' 'sha256-YJO/M9OgDKEBRKGqp4Zd07dzlagbB+qmKgThG52u/Mk='; object-src 'none'"
  description = "The policy directives and their values that CloudFront includes as values for the Content-Security-Policy HTTP response header."
}