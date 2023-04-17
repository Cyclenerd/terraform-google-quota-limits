module "quota-limits" {
  source     = "../../"
  project_id = var.project_id
  limits     = var.limits
}