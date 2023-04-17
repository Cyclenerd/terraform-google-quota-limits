module "quota-limits" {
  source     = "Cyclenerd/quota-limits/google"
  version    = "1.0.0"
  project_id = var.project_id
  limits     = var.limits
}