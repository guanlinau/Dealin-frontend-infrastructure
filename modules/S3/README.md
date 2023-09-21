# S3 module Variable Samples

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
