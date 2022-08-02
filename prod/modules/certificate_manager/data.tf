data "aws_route53_zone" "route53" {
  name         = "fooiy.com."
  private_zone = false
}
