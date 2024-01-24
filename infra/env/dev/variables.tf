variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "content_security_policy" {
  type        = string
  default     = "frame-ancestors 'none'; default-src 'none'; img-src 'self'; script-src 'self'; script-src-elem 'self' 'sha256-/rbuLmjOhdrXDXnFnTI3s+BYoAyRHYELKon3OljZ3I8=' 'sha256-QKOHfaooBSX/Bn5NbamY975gpno/BvAGbjsuLDRYT5M=' 'sha256-6keeQcu9Kh8gXXIlOpmNHs7f2UzbAyMVaH+sBk0iDwo=' use.typekit.net; style-src 'self' 'sha256-CwE3Bg0VYQOIdNAkbB/Btdkhul49qZuwgNCMPgNY5zw=' 'sha256-MZKTI0Eg1N13tshpFaVW65co/LeICXq4hyVx6GWVlK0=' 'sha256-LpfmXS+4ZtL2uPRZgkoR29Ghbxcfime/CsD/4w5VujE=' 'sha256-YJO/M9OgDKEBRKGqp4Zd07dzlagbB+qmKgThG52u/Mk='; font-src 'self'; object-src 'none';"
  description = "The policy directives and their values that CloudFront includes as values for the Content-Security-Policy HTTP response header."
}