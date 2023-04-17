# Limit Instance Numbers

This example shows how to limit the Google Compute Engine instance numbers per project.

All [default metrics](https://github.com/Cyclenerd/terraform-google-quota-limits#input_metrics) (input `metrics`) in all [default regions](https://github.com/Cyclenerd/terraform-google-quota-limits#input_regions) (input `regions`) are set to `0`.
Additionally, all instances (metric `compute.googleapis.com/instances` in all regions are set to `0` except for region [`europe-west1`](https://gcloud-compute.com/europe-west1.html) and [`europe-west4`](https://gcloud-compute.com/europe-west4.html).
In region `europe-west1` and `europe-west4`, one (`1`) instance with a total of four (`4`) [N1 CPUs](https://gcloud-compute.com/instances.html) (metric `compute.googleapis.com/cpus`) is allowed.

## Example

### terraform.tfvars

```hcl
project_id = "your-project-id"
limits = {
  "europe-west1" = {
    "compute.googleapis.com/instances" = "1"
    "compute.googleapis.com/cpus"      = "4"
  }
  "europe-west4" = {
    "compute.googleapis.com/instances" = "1"
    "compute.googleapis.com/cpus"      = "4"
  }
}
```

### main.tf

```hcl
module "quota-limits" {
  source     = "Cyclenerd/quota-limits/google"
  version    = "1.0.0"
  project_id = var.project_id
  limits     = var.limits
}
```