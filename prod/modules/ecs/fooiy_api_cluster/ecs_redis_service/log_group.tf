resource "aws_s3_bucket" "prod_api-redis_log_storage" {
  bucket = "prod-api-redis-log-storage"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::033677994240:root"
        },
        "Action" : "s3:PutObject",
        "Resource" : "arn:aws:s3:::prod-api-redis-log-storage/*"
      }
    ]
  })

  lifecycle_rule {
    id      = "log_lifecycle"
    prefix  = ""
    enabled = true

    expiration {
      days = 10
    }
  }

  force_destroy = true
}


resource "aws_cloudwatch_log_group" "prod_api-redis_cloudwatch_log_group" {
  name = "/aws/ecs/api-redis"

  tags = {
    Environment = "prod"
    Application = "api-redis.fooiy.com"
  }
}
