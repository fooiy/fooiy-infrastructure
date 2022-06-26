resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name
  
  tags = {
    Name = "${var.bucket_name}"
  }
}

resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.s3.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "s3"{
  bucket = aws_s3_bucket.s3.id
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
        "Resource": "arn:aws:s3:::${aws_s3_bucket.s3.bucket}/*"
      }
    ]
  }
  POLICY
  
}