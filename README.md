# S3 module Variable Samples

### 1 . region = "ap-southeast-2" (required, must be us-east-1 for cdn acm validation)

### 2 . us_east_1_region = "us-east-1" (required, must be us-east-1 for cdn acm validation)

### 2. 'app_environment' (Required)

### 3. 's3_bucket_name' (Required)

### 4. 'website' (Required. Give it a empty map {} when creating a bucket -not used for hosting website)

```
website = {
  "index_document" = "index.html",
  "error_document" = "404.html"
   "redirect_all_requests_to" = "www.example.com"
}
```

```
For website variable:
1- 'index_document' is optional. Required if redirect_all_requests_to is not specified.

2- 'error_document' is optional. Conflicts with 'redirect_all_requests_to'

3- 'redirect_all_requests_to' is optional, Required if index_document is not specified, and it is conflicts with error_document, index_document'
```

### 5. 'cors_rules' (Required. Give it an empty list [], when you don't want use it)

```
cors_rules = [
        {
            "allowed_headers" = ["Authorization","Content-Length"]
            "allowed_methods" = ["GET"]
            "allowed_origins" = ["*"]
            "max_age_seconds" = 3000
        },
        {
           "allowed_headers" = ["*"]
            "allowed_methods" = ["POST", "PUT", "DELETE"]
            "allowed_origins" = ["www.example.au", "example.au"]
            "max_age_seconds" = 3000
        }
     ]
```

```
1- You are allowed to set one or more rules as a map in the core_rules list.

2- "allowed_headers": (Optional) It is a list, you can choose "*", "Authorization" or "Content-Length".

3- "allowed_methods": (Required) It is a list, you can choose "*", "POST", "PUT", "DELETE", "GET"

4- "allowed_origins": (Required) It is list, you can choose "*", or your domain.

5- "max_age_seconds": (Optional) Time in seconds that your browser is to cache the preflight response for the specified resource.
```

### 5. 'versioning' (Required)

```
versioning = false
```

### 6. 'acl_access_type' (Required)

```
1- only "private" or "public-read" is allowed, and default value is "private"
```

### 7. Variable for S3 bucket used to store front-end environment variables

```
s3_bucket_name_env = "xxx"
```

# Route53 variables sample

### 1. record_type = "A"

# Variables for cloudfront

```
cloudfront_origin_shield     = true

cf_default_cache_min_ttl     = 0

cf_default_cache_max_ttl     = 86400

cf_default_cache_default_ttl = 3600

cf_viewer_protocol_policy    = "redirect-to-https"

1- "The variable value must be 'allow-all', 'https-only' or 'redirect-to-https'."

cf_price_class               = "PriceClass_All"

1- "The variable value must be 'PriceClass_All', 'PriceClass_200', 'PriceClass_100'

cf_restriction_type          = "none"

1- "The variable value must be 'none', 'whitelist', 'blacklist'

cf_restriction_locations     = []

1- "The country shorthand names"
```

# Variables for ACM

```
validation_method = "DNS"

1- "Valid values are DNS, EMAIL or NONE"

key_algorithm     = "RSA_2048"

1-  "Valid values are 'RSA_2048', 'EC_prime256v1' or 'EC_secp384r1'"


```
