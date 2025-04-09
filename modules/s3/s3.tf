// create employer's static s3 bucket for cloudfront
resource "aws_s3_bucket" "employer_static_bucket" {
  bucket = "${var.prefix}-employer-static-bucket"
  tags = {
    Name = "${var.prefix}-employer-static-bucket"
  }
}

// create aws_s3_bucket_policy for cloudfront
resource "aws_s3_bucket_policy" "employer_static_bucket_policy" {
  bucket = aws_s3_bucket.employer_static_bucket.bucket
  policy = data.aws_iam_policy_document.employer_static_oac_access.json
}

data "aws_iam_policy_document" "employer_static_oac_access" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.employer_static_bucket.arn,
      "${aws_s3_bucket.employer_static_bucket.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [var.employer_cloudfront_distribution_arn]
    }
  }
}

// create s3 resume_bucket
resource "aws_s3_bucket" "resume_bucket" {
  bucket = "${var.prefix}-resume-bucket"
  tags = {
    Name = "${var.prefix}-resume-bucket"
  }
}

resource "aws_s3_bucket_cors_configuration" "resume_bucket_cors" {
  bucket = aws_s3_bucket.resume_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}

// s3 public bucket
resource "aws_s3_bucket" "asset_bucket" {
  bucket = "${var.prefix}-asset-bucket"
  tags = {
    Name = "${var.prefix}-asset-bucket"
  }
}

resource "aws_s3_bucket_cors_configuration" "asset_bucket_cors" {
  bucket = aws_s3_bucket.asset_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}

// create aws_s3_bucket_policy for asset_bucket_cors
resource "aws_s3_bucket_policy" "asset_bucket_policy" {
  bucket = aws_s3_bucket.asset_bucket.bucket
  policy = data.aws_iam_policy_document.asset_bucket_oac_access.json
}

data "aws_iam_policy_document" "asset_bucket_oac_access" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.asset_bucket.arn,
      "${aws_s3_bucket.asset_bucket.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [var.employer_cloudfront_distribution_arn]
    }
  }
}
