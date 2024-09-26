terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.11.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }

  # backend "gcs" {
  #   bucket = "bucket_name"
  #   prefix = "playpit"
  # }
}

provider "google" {
  project     = var.gcp_project
  region      = var.gcp_region
}