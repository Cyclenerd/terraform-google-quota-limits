/**
 * Copyright 2023 Nils Knieling
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  description = "The project ID that should be limited"
  type        = string
  nullable    = false
}

variable "regions" {
  description = "Google Cloud regions that should be limited"
  type        = list(string)
  nullable    = false
  default = [
    "asia-east1",
    "asia-east2",
    "asia-northeast1",
    "asia-northeast2",
    "asia-northeast3",
    "asia-south1",
    "asia-south2",
    "asia-southeast1",
    "asia-southeast2",
    "australia-southeast1",
    "australia-southeast2",
    "europe-central2",
    "europe-north1",
    "europe-southwest1",
    "europe-west1",
    "europe-west10",
    "europe-west12",
    "europe-west2",
    "europe-west3",
    "europe-west4",
    "europe-west6",
    "europe-west8",
    "europe-west9",
    "me-central1",
    "me-west1",
    "northamerica-northeast1",
    "northamerica-northeast2",
    "southamerica-east1",
    "southamerica-west1",
    "us-central1",
    "us-east1",
    "us-east4",
    "us-east5",
    "us-south1",
    "us-west1",
    "us-west2",
    "us-west3",
    "us-west4",
  ]
}

variable "metrics" {
  description = "The metrics that should be limited and set to 0"
  type        = list(string)
  nullable    = false
  default = [
    "compute.googleapis.com/a2_cpus",
    "compute.googleapis.com/c2_cpus",
    "compute.googleapis.com/c2d_cpus",
    "compute.googleapis.com/c3_cpus",
    "compute.googleapis.com/cpus",
    "compute.googleapis.com/m1_cpus",
    "compute.googleapis.com/m2_cpus",
    "compute.googleapis.com/m3_cpus",
    "compute.googleapis.com/n2_cpus",
    "compute.googleapis.com/n2d_cpus",
    "compute.googleapis.com/nvidia_a100_80gb_gpus",
    "compute.googleapis.com/nvidia_a100_gpus",
    "compute.googleapis.com/nvidia_k80_gpus",
    "compute.googleapis.com/nvidia_p100_gpus",
    "compute.googleapis.com/nvidia_p4_gpus",
    "compute.googleapis.com/nvidia_p4_vws_gpus",
    "compute.googleapis.com/nvidia_t4_gpus",
    "compute.googleapis.com/nvidia_t4_vws_gpus",
    "compute.googleapis.com/nvidia_v100_gpus",
    "compute.googleapis.com/t2a_cpus",
    "compute.googleapis.com/t2d_cpus",
  ]
}

variable "limits" {
  description = "The qutoa limits per metric and region to be limited and set to the given value"
  type        = map(map(number))
  default     = {}
}