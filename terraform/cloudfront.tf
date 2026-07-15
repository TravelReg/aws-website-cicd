resource "aws_cloudfront_origin_access_control" "website" {

  name = "visitor-counter-oac"

  origin_access_control_origin_type = "s3"

  signing_behavior = "always"

  signing_protocol = "sigv4"
}

resource "aws_cloudfront_distribution" "website" {

  enabled = true

  default_root_object = "index.html"

  origin {

    domain_name = aws_s3_bucket.website.bucket_regional_domain_name

    origin_id = "websiteS3"

    origin_access_control_id = aws_cloudfront_origin_access_control.website.id
  }

  default_cache_behavior {

    allowed_methods = [
      "GET",
      "HEAD"
    ]

    cached_methods = [
      "GET",
      "HEAD"
    ]

    target_origin_id = "websiteS3"

    viewer_protocol_policy = "redirect-to-https"

    compress = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

data "aws_iam_policy_document" "website_policy" {

  statement {

    principals {
      type = "Service"

      identifiers = [
        "cloudfront.amazonaws.com"
      ]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.website.arn}/*"
    ]

    condition {
      test = "StringEquals"

      variable = "AWS:SourceArn"

      values = [
        aws_cloudfront_distribution.website.arn
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "website" {

  bucket = aws_s3_bucket.website.id

  policy = data.aws_iam_policy_document.website_policy.json
}