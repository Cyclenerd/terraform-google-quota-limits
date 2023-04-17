variable "project_id" {
  description = "The project ID that should be limited"
  type        = string
  nullable    = false
}

variable "limits" {
  description = "The qutoa limits per metric and region to be limited and set to the given value"
  type        = map(map(number))
  default     = {}
}