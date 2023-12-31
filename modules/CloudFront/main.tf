locals {
  env = terraform.workspace
}

# add oac model
resource "aws_cloudfront_origin_access_control" "cloudfront_s3_oac" {
  name                              =  var.app_environment == "pro" ? "Pro CloudFront S3 OAC" : "CloudFront S3 OAC"
  description                       = "Cloud Front S3 OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# Create Cloudfront distribution
resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name              = var.bucket_regional_domain_name
    origin_id                = "origin-bucket-${var.s3_bucket_id}"
    origin_access_control_id = aws_cloudfront_origin_access_control.cloudfront_s3_oac.id
    origin_shield {
      enabled              = var.cloudfront_origin_shield
      origin_shield_region = var.cloudfront_origin_shield_region
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "my-cloudfront"
  default_root_object = "index.html"


  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "origin-bucket-${var.s3_bucket_id}"
    compress         = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = var.cf_viewer_protocol_policy
    min_ttl                = var.cf_default_cache_min_ttl
    default_ttl            = var.cf_default_cache_default_ttl
    max_ttl                = var.cf_default_cache_max_ttl
  }

  price_class = var.cf_price_class

  custom_error_response {
    error_caching_min_ttl =200
    error_code = 404
    response_code = 200
    response_page_path = "/index.html"
  }
  custom_error_response {
    error_caching_min_ttl =200
    error_code = 403
    response_code = 200
    response_page_path = "/index.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = var.cf_restriction_type
      locations        = var.cf_restriction_locations
    }
  }

  aliases = var.cloudfront_alias_name

  viewer_certificate {
    acm_certificate_arn            = var.cf_acm_certificate_arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  tags = {
    Name        = "${var.app_environment}-cloudfront"
    Environment = local.env
  }
}


