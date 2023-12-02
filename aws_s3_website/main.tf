data "aws_region" "current" {}

resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  source       = var.index_page
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.website.id

  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website.arn}/*"
      }
    ]
  })
}

output "website_url" {
  value = "http://${aws_s3_bucket.website.bucket}.s3-website-${data.aws_region.current.name}.amazonaws.com"
}