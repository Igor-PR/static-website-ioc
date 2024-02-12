resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.static_website_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_the_public.json
}

data "aws_iam_policy_document" "allow_access_from_the_public" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.static_website_bucket.arn}/*",
    ]
  }
}
