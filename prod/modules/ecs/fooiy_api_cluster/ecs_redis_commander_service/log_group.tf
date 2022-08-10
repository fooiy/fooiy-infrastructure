resource "aws_s3_bucket" "prod_redis_commander_log_storage" {
  bucket = "prod-redis-commander-log-storage"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::033677994240:root"
        },
        "Action" : "s3:PutObject",
        "Resource" : "arn:aws:s3:::prod-redis-commander-log-storage/*"
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


resource "aws_cloudwatch_log_group" "prod_redis_commander_cloudwatch_log_group" {
  name = "/aws/ecs/redis/commander"

  tags = {
    Environment = "prod"
    Application = "api.fooiy.com"
  }
}
