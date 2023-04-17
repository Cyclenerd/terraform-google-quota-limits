# Terraform versions
terraform {
  required_version = ">= 1.4.2"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.4.0"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 4.61.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.61.0"
    }
  }
}