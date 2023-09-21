
region           = "ap-southeast-2"
us_east_1_region = "us-east-1"
app_environment  = "uat"
s3_bucket_name   = "offerripple-front"
app_name         = "offerripple"
web_domain_name  = "offerripple.com"

# Variable for S3 bucket used to store front-end environment variables
s3_bucket_name_env = "offerripple-env"

# Belows are For s3 bucket configuration

# For host a website variable
website = {
  "index_document" = "index.html",
  "error_document" = "index.html"
}
#variables for route53 record
record_type = "A"
# For cors
cors_rules = [
  {
    "allowed_headers" = ["*"]
    "allowed_methods" = ["GET"]
    "allowed_origins" = ["*"]
    "max_age_seconds" = 3000
  },
  {
    "allowed_headers" = ["*"]
    "allowed_methods" = ["POST", "PUT", "DELETE"]
    "allowed_origins" = ["www.offerripple.com", "offerripple.com", "uat.offerripple.com"]
    "max_age_seconds" = 3000
  }
]

# For versioning
versioning = true

# For all public access s3 bucket or not
acl_access_type = "private"
# acl_access_type = "public-read"

# Variables for cloudfront
cloudfront_origin_shield     = true
cf_default_cache_min_ttl     = 0
cf_default_cache_max_ttl     = 86400
cf_default_cache_default_ttl = 3600
cf_viewer_protocol_policy    = "redirect-to-https"
cf_price_class               = "PriceClass_All"
cf_restriction_type          = "none"
cf_restriction_locations     = []

# Variables  for ACM
validation_method = "DNS"
key_algorithm     = "RSA_2048"

