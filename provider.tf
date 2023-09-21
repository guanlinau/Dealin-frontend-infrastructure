terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }

  }
  required_version = ">=v1.4.5"
}
provider "aws" {
  region = var.region
}

# provider for create cloudfront acm in us_east_1 region, required by cloudfront
provider "aws" {
  alias  = "us_east_1_region"
  region = var.us_east_1_region
}