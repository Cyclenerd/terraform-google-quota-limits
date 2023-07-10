# Update Google Cloud Consumer Quota Limits

[![Bagde: Google Cloud](https://img.shields.io/badge/Google%20Cloud-%234285F4.svg?logo=google-cloud&logoColor=white)](https://github.com/Cyclenerd/terraform-google-quota-limits#readme)
[![Badge: Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?logo=terraform&logoColor=white)](https://github.com/Cyclenerd/terraform-google-quota-limits#readme)
[![Bagde: CI](https://github.com/Cyclenerd/terraform-google-quota-limits/actions/workflows/ci.yml/badge.svg)](https://github.com/Cyclenerd/terraform-google-quota-limits/actions/workflows/ci.yml)
[![Bagde: GitHub](https://img.shields.io/github/license/cyclenerd/terraform-google-quota-limits)](https://github.com/Cyclenerd/google-cloud-pricing-cost-calculator/blob/master/LICENSE)

Override consumer quota limits for Google Cloud Platform projects.
Ideal to limit the use of expensive CPUs and GPUs.

[![Screenshot: C3 CPU Quotas](https://raw.githubusercontent.com/Cyclenerd/terraform-google-quota-limits/master/img/quotas_c3_cpus.png)](https://github.com/Cyclenerd/terraform-google-quota-limits#readme)

> **Warning**
> This module cannot be used to grant more quota than would be allowed by admin overrides, producer overrides, or the default limit of the service.

> **Note**
> You can also limit Compute Engine resources with custom constraints.
> More details can be found in the [Google Cloud documentation](https://cloud.google.com/compute/docs/access/custom-constraints).

## Example

1. All [default metrics](https://github.com/Cyclenerd/terraform-google-quota-limits#input_metrics) (input `metrics`) in all [default regions](https://github.com/Cyclenerd/terraform-google-quota-limits#input_regions) (input `regions`) are set to `0`.
1. In region `europe-west4`,
  * four (`4`) [N1 and E2 CPUs](https://gcloud-compute.com/instances.html) (metric `compute.googleapis.com/cpus`) and
  * four (`4`) [C3 CPUs](https://gcloud-compute.com/instances.html) (metric `compute.googleapis.com/c3_cpus`) are allowed.

```hcl
module "quota-limits" {
  source     = "Cyclenerd/quota-limits/google"
  version    = "~> 1.0.0"
  project_id = "your-project-id"
  limits     = {
    "europe-west4" = {
      "compute.googleapis.com/cpus"    = "4" # N1, E2
      "compute.googleapis.com/c3_cpus" = "4" # C3
    }
  }
}
```

👉 **[More examples](https://github.com/Cyclenerd/terraform-google-quota-limits/tree/master/examples)**

## Quotas

Lists (CSV) with service quota metrics for a consumer:

* [Compute Engine `compute.googleapis.com`](https://github.com/Cyclenerd/terraform-google-quota-limits/blob/master/tools/compute.csv)
* [Cloud Storage `storage.googleapis.com`](https://github.com/Cyclenerd/terraform-google-quota-limits/blob/master/tools/storage.csv)
* [BigQuery `bigquery.googleapis.com`](https://github.com/Cyclenerd/terraform-google-quota-limits/blob/master/tools/bigquery.csv)

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | >= 4.61.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_limits"></a> [limits](#input\_limits) | The qutoa limits per metric and region to be limited and set to the given value | `map(map(number))` | `{}` | no |
| <a name="input_metrics"></a> [metrics](#input\_metrics) | The metrics that should be limited and set to 0 | `list(string)` | <pre>[<br>  "compute.googleapis.com/a2_cpus",<br>  "compute.googleapis.com/c2_cpus",<br>  "compute.googleapis.com/c2d_cpus",<br>  "compute.googleapis.com/c3_cpus",<br>  "compute.googleapis.com/cpus",<br>  "compute.googleapis.com/m1_cpus",<br>  "compute.googleapis.com/m2_cpus",<br>  "compute.googleapis.com/m3_cpus",<br>  "compute.googleapis.com/n2_cpus",<br>  "compute.googleapis.com/n2d_cpus",<br>  "compute.googleapis.com/nvidia_a100_80gb_gpus",<br>  "compute.googleapis.com/nvidia_a100_gpus",<br>  "compute.googleapis.com/nvidia_k80_gpus",<br>  "compute.googleapis.com/nvidia_p100_gpus",<br>  "compute.googleapis.com/nvidia_p4_gpus",<br>  "compute.googleapis.com/nvidia_p4_vws_gpus",<br>  "compute.googleapis.com/nvidia_t4_gpus",<br>  "compute.googleapis.com/nvidia_t4_vws_gpus",<br>  "compute.googleapis.com/nvidia_v100_gpus",<br>  "compute.googleapis.com/t2a_cpus",<br>  "compute.googleapis.com/t2d_cpus"<br>]</pre> | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID that should be limited | `string` | n/a | yes |
| <a name="input_regions"></a> [regions](#input\_regions) | Google Cloud regions that should be limited | `list(string)` | <pre>[<br>  "asia-east1",<br>  "asia-east2",<br>  "asia-northeast1",<br>  "asia-northeast2",<br>  "asia-northeast3",<br>  "asia-south1",<br>  "asia-south2",<br>  "asia-southeast1",<br>  "asia-southeast2",<br>  "australia-southeast1",<br>  "australia-southeast2",<br>  "europe-central2",<br>  "europe-north1",<br>  "europe-southwest1",<br>  "europe-west1",<br>  "europe-west12",<br>  "europe-west2",<br>  "europe-west3",<br>  "europe-west4",<br>  "europe-west6",<br>  "europe-west8",<br>  "europe-west9",<br>  "me-central1",<br>  "me-west1",<br>  "northamerica-northeast1",<br>  "northamerica-northeast2",<br>  "southamerica-east1",<br>  "southamerica-west1",<br>  "us-central1",<br>  "us-east1",<br>  "us-east4",<br>  "us-east5",<br>  "us-south1",<br>  "us-west1",<br>  "us-west2",<br>  "us-west3",<br>  "us-west4"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_limits"></a> [limits](#output\_limits) | Quota limits per metric and region |
| <a name="output_metrics"></a> [metrics](#output\_metrics) | The metrics that are limited |
| <a name="output_quotas"></a> [quotas](#output\_quotas) | The quotas per metric and region that are limited |
| <a name="output_regions"></a> [regions](#output\_regions) | The regions that are limited |
<!-- END_TF_DOCS -->

## License

All files in this repository are under the [Apache License, Version 2.0](LICENSE) unless noted otherwise.