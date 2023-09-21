output "front_subdomain_url" {
  value = module.cloudfront_route_record.subdomain_name
}
output "app_environment" {
  value = var.app_environment
}