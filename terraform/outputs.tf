output "api_url" {
  value = aws_apigatewayv2_api.counter_api.api_endpoint
}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.website.domain_name
}

output "bucket_name" {
  value = aws_s3_bucket.website.bucket
}