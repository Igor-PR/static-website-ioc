resource "aws_s3_bucket" "static_website_bucket" {
  bucket = var.domain_name

  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "static_website_bucket_ownership" {
  bucket = aws_s3_bucket.static_website_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "static_website_bucket_access" {
  bucket = aws_s3_bucket.static_website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "static_website_bucket_ack" {
  depends_on = [
    aws_s3_bucket_ownership_controls.static_website_bucket_ownership,
    aws_s3_bucket_public_access_block.static_website_bucket_access,
  ]

  bucket = aws_s3_bucket.static_website_bucket.id
  acl    = "public-read"
}


module "template_files" {
  source   = "hashicorp/dir/template"
  base_dir = "${path.module}/static"
}

resource "aws_s3_object" "objects" {
  for_each     = module.template_files.files
  bucket       = aws_s3_bucket.static_website_bucket.id
  key          = each.key
  content_type = each.value.content_type
  source       = each.value.source_path
  content      = each.value.content
  etag         = each.value.digests.md5
}


resource "aws_s3_bucket_website_configuration" "static_website_config" {
  bucket = aws_s3_bucket.static_website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
