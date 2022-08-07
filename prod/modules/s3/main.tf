resource "aws_s3_bucket" "dev_fooiy" {
  bucket = "dev-fooiy"
}

resource "aws_s3_bucket_acl" "dev_s3_acl" {
  bucket = aws_s3_bucket.dev_fooiy.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "dev_s3"{
  bucket = aws_s3_bucket.dev_fooiy.id
  policy = <<POLICY
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "AllowPublicRead",
        "Effect": "Allow",
        "Principal": {
          "AWS": "*"
        },
        "Action": ["s3:GetObject","s3:PutObject"],
        "Resource": "arn:aws:s3:::${aws_s3_bucket.dev_fooiy.bucket}/*"
      }
    ]
  }
  POLICY
}

resource "aws_s3_bucket" "prod_fooiy" {
  bucket = "prod-fooiy"
}

resource "aws_s3_bucket_acl" "prod_s3_acl" {
  bucket = aws_s3_bucket.prod_fooiy.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "prod_s3"{
  bucket = aws_s3_bucket.prod_fooiy.id
  policy = <<POLICY
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "AllowPublicRead",
        "Effect": "Allow",
        "Principal": {
          "AWS": "*"
        },
        "Action": ["s3:GetObject","s3:PutObject"],
        "Resource": "arn:aws:s3:::${aws_s3_bucket.prod_fooiy.bucket}/*"
      }
    ]
  }
  POLICY
}