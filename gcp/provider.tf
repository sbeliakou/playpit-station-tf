terraform {
  required_version = "1.6.5"

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
}