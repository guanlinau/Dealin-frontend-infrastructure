# terraform {
#   cloud {
#     organization = "Dealin"

#     workspaces {
#       name = "terraform_frontend_uat"
#     }
#   }
# }

terraform {
  backend "s3" {
    bucket         = "offerripple-terraform-state"
    key            = "offerripple-front1.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "offerripple-front-lock-dynamo"
    encrypt              = true
  }
}

