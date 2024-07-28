#Resource to create s3 bucket
resource "aws_s3_bucket" "buckettest7770"{
  bucket = "buckettest7770"
  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "buckettest7770"
  }
}

#Resource to enable encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "buckettest7770-demo" {
  bucket = aws_s3_bucket.buckettest7770.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


# accounting-journal-files ////////////////////////////////////
/*resource "aws_s3_bucket" "accounting-journal-files" {
  bucket = "accounting-journal-files"

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
}*/
