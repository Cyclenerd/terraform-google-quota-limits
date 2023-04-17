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