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
  policy = data.aws_iam_policy_document.employer_cloudfront_oac_access.json
}

data "aws_iam_policy_document" "employer_cloudfront_oac_access" {
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

// s3 public bucket
resource "aws_s3_bucket" "asset_bucket" {
  bucket = "${var.prefix}-asset-bucket"
  tags = {
    Name = "${var.prefix}-asset-bucket"
  }
}
