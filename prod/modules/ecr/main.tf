resource "aws_ecr_repository" "dev-api_fooiy_com" {
  name                 = "dev-api.fooiy.com"
  image_tag_mutability = "MUTABLE"
}
