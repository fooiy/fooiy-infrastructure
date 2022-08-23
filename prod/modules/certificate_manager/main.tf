module "fooiy_certification" {
  source = "./certification"

  domain_name      = "*.fooiy.com"
  root_domain_name = "fooiy.com"
}
