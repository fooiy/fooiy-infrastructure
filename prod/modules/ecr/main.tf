module "dev-api_fooiy_com" {
  source              = "./modules"
  ecr_repository_name = "dev-api.fooiy.com"
}

module "admin_fooiy_com" {
  source              = "./modules"
  ecr_repository_name = "admin.fooiy.com"
}

module "api_fooiy_com" {
  source              = "./modules"
  ecr_repository_name = "api.fooiy.com"
}

module "www_fooiy_com" {
  source              = "./modules"
  ecr_repository_name = "www.fooiy.com"
}
