locals {
  regions = toset(flatten([var.regions, [
    for region_key, region_value in var.limits : [region_key]
  ]]))
  metrics = toset(flatten([var.metrics, [
    for region_key, region_value in var.limits : [for metric_key, metric_value in region_value : metric_key]
  ]]))
  limits = merge([
    for region_key, region_value in var.limits : {
      for metric_key, metric_value in region_value : "${region_key}/${metric_key}" => metric_value
    }
  ]...)
  quotas = merge([
    for region in local.regions : {
      for metric in local.metrics :
      "${region}/${metric}" => {
        "region"         = tostring(region)
        "service"        = split("/", metric)[0]
        "metric"         = tostring(metric)
        "override_value" = lookup(local.limits, "${region}/${metric}", 0)
      }
    }
  ]...)
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_usage_consumer_quota_override
resource "google_service_usage_consumer_quota_override" "quota" {
  for_each = local.quotas
  provider = google-beta
  project  = var.project_id
  service  = each.value.service
  metric   = urlencode(each.value.metric)
  # The limit on the metric, e.g. /project/region.
  # Make sure that limit is in a format that doesn't start with 1/ or contain curly braces.
  # E.g. use /project/user instead of 1/{project}/{user}.
  limit          = urlencode("/project/region")
  override_value = each.value.override_value
  # If the new quota would decrease the existing quota by more than 10%,
  # the request is rejected. If force is true, that safety check is ignored.
  force = true
  # Regions
  dimensions = {
    region = each.value.region
  }
}