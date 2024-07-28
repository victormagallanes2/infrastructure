
locals {
  tke_portal_s3_origin_id = "tkeportalbucket"

}

// certificate code

/*provider "aws" {
  alias = "cloudfront"
  region = "us-east-1"
  profile = "${var.environment == "prod" ? "arya" : "arya-dev"}"
}

data "aws_acm_certificate" "cert_global" {
  domain = "controllerbi.tech"
  statuses = ["ISSUED"]
  types = ["AMAZON_ISSUED"]
  provider = aws.cloudfront
}*/

# TKE portal ////////////////////////////////////
resource "aws_s3_bucket" "tkeportalbucket" {
  bucket = "tke.portal-${var.environment}"

  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }
  website {
    index_document = "index.html"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "tkeportalbucket-oai" {
  comment = "tke.portal OAI"
}

resource "aws_s3_bucket_policy" "tkeportalbucket-policy" {
  bucket = aws_s3_bucket.tkeportalbucket.id

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "2",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.tkeportalbucket-oai.id}"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::tke.portal-${var.environment}/*"
        }
    ]
  }
EOF
depends_on = [
  aws_cloudfront_distribution.tkeportalbucket-distribution
]
}

