resource "aws_s3_bucket" "dev_fooiy" {
  bucket = "dev-fooiy"
}

resource "aws_s3_bucket_acl" "dev_s3_acl" {
  bucket = aws_s3_bucket.dev_fooiy.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "s3"{
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
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.dev_fooiy.bucket}/*"
      }
    ]
  }
  POLICY
  
}