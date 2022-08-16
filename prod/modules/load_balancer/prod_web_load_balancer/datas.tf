data "aws_acm_certificate" "fooiy_certification" {
  domain = "*.fooiy.com"
}

data "aws_acm_certificate" "fooiy_root_certification" {
  domain = "fooiy.com"
}
