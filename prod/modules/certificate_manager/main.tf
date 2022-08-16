module "fooiy_root_certification" {
  source = "./certification"

  domain_name = "fooiy.com"
}

module "fooiy_certification" {
  source = "./certification"

  domain_name = "*.fooiy.com"
}
