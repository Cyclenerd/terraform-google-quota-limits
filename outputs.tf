output "limits" {
  description = "Quota limits per metric and region"
  value       = local.limits
}

output "regions" {
  description = "The regions that are limited"
  value       = local.regions
}

output "metrics" {
  description = "The metrics that are limited"
  value       = local.metrics
}

output "quotas" {
  description = "The quotas per metric and region that are limited"
  value       = local.quotas
}